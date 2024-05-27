//
//  WatchAppConnecter.swift
//  NC2
//
//  Created by Stevans Calvin Candra on 27/05/24.
//

import Foundation
import WatchConnectivity

class WatchAppConnecter: NSObject, WCSessionDelegate, ObservableObject {
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func sendData(_ itemTargets: [Double]) {
        if session.isReachable {
            let data: [String : Any] = [
                "Food" : itemTargets[0],
                "ActiveEnergy" : itemTargets[1],
                "Water" : itemTargets[2]
            ]
            session.sendMessage(data, replyHandler: nil)
        } else {
            print("No Reachable Session")
        }
    }
    
}
