//
//  IOSAppConnector.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 27/05/24.
//

import Foundation
import SwiftData
import WatchConnectivity

class IOSAppConnector: NSObject, WCSessionDelegate, ObservableObject {
    
    var session: WCSession
    @Published var receivedData: [String : Any] = [:]
    @Published var didReceiveData: Bool = false
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        self.receivedData = message
        self.didReceiveData = true
    }
}
