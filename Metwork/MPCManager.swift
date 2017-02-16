//
//  MPCManager.swift
//  Metwork
//
//  Created by Michael Young on 2/14/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import MultipeerConnectivity

protocol MPCManagerDelegate {
    func foundPeer()
    func lostPeer()
    func invintationWasReceived(fromPeer: String)
    func connectedWithPeer(peerID: MCPeerID)
}

class MPCManager: NSObject {
    var session: MCSession!
    var peer: MCPeerID!
    var browser: MCNearbyServiceBrowser!
    var advertiser: MCNearbyServiceAdvertiser!
    
    var foundPeers = [MCPeerID]()
    // completion handler declaration
    var invitationHandler: ((Bool, MCSession?) -> Void)!
    
    var delegate: MPCManagerDelegate?
    
    override init() {
        super.init()
        
        // MARK: TODO - change displayName to custom string
        peer = MCPeerID(displayName: UIDevice.current.name)
        
//        session = MCSession(peer: peer, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.none)
        session = MCSession(peer: peer)
        session.delegate = self
        
        browser = MCNearbyServiceBrowser(peer: peer, serviceType: Constants.MPC.serviceType)
        browser.delegate = self
        
        // MARK: TODO - discoveryInfo modification - add information to pass upon discovery - key/value = string/string
        advertiser = MCNearbyServiceAdvertiser(peer: peer, discoveryInfo: nil, serviceType: Constants.MPC.serviceType)
        advertiser.delegate = self
    }
}

extension MPCManager: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("*******************************Connected to session: \(session)")
            delegate?.connectedWithPeer(peerID: peerID)
        case MCSessionState.connecting:
            print("*******************************Connecting to session: \(session)")
        default:
            print("*******************************Did not connect to session: \(session)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
//        let dictionary: [String : AnyObject] = ["data" : data as AnyObject, "fromPeer": peerID]
        print("didReceive data called**************************************")
        let dictionary: [String : Any] = ["data" : data, "fromPeer" : peerID]
        NotificationCenter.default.post(name: Constants.MPC.receivedDataNotification, object: dictionary)
    }
    
    // MARK: TODO - refactor
    func sendData(dictionaryWithData dictionary: [String : String], toPeer targetPeer: MCPeerID) -> Bool {
        print("******************************Entered sendData func")
        let dataToSend = NSKeyedArchiver.archivedData(withRootObject: dictionary)
        print("dataToSend: \(dataToSend)")
        let peersArray = NSArray(object: targetPeer)
        print("peersArray: \(peersArray)")
        
        do {
            try session.send(dataToSend, toPeers: peersArray as! [MCPeerID], with: MCSessionSendDataMode.reliable)
            print("********************************Trying to send data")
        } catch {
            print("******************************sendDataFunc return false")
            return false
        }
        print("******************************sendDataFunc return true")
        return true
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) { }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) { }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) { }
    
}



extension MPCManager: MCNearbyServiceBrowserDelegate {
    // adds found peers to foundPeers array
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        foundPeers.append(peerID)
        delegate?.foundPeer()
    }
    
    // handle peers that are no longer discoverable
    // MARK: TODO - handle case where connection is lost between peers and if one peer terminates app. Post Notification and observe
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        for (index, aPeer) in foundPeers.enumerated() {
            if aPeer == peerID {
                foundPeers.remove(at: index)
                break
            }
        }
        delegate?.lostPeer()
    }
    
    // error handling if browsing cannot start
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print(error.localizedDescription)
    }
}

extension MPCManager: MCNearbyServiceAdvertiserDelegate {
    // invitation handler
    // MARK: TODO - peerID displayName to custom
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        self.invitationHandler = invitationHandler
        delegate?.invintationWasReceived(fromPeer: peerID.displayName)
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        print(error.localizedDescription)
    }
}
