import Foundation
import WatchConnectivity

// I didn't manage to get this class referenced during compile
// so I needed to copy paste it's content to contentview

enum HappinessLevel: String, CaseIterable, Identifiable {
    case low, normal, high
    var id: Self { self }
}

class WatchViewModel: NSObject, ObservableObject {
    var session: WCSession

    @Published var bmi = 0
    @Published var happiness : HappinessLevel = .high

    // Add more cases if you have more receive method
    enum WatchReceiveMethod: String {
        case sendBmiToWatch
    }
    
    // Add more cases if you have more sending method
    enum WatchSendMethod: String {
        case sendHappinessToFlutter
    }
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func sendDataMessage(for method: WatchSendMethod, data: [String: Any] = [:]) {
        sendMessage(for: method.rawValue, data: data)
    }
    
}

extension WatchViewModel: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    // Receive message From AppDelegate.swift that send from iOS devices
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            guard let method = message["method"] as? String, let enumMethod = WatchReceiveMethod(rawValue: method) else {
                return
            }
            
            switch enumMethod {
            case .sendBmiToWatch:
                self.bmi = (message["data"] as? Int) ?? 0
            }
        }
    }
    
    func sendMessage(for method: String, data: [String: Any] = [:]) {
        guard session.isReachable else {
            return
        }
        let messageData: [String: Any] = ["method": method, "data": data]
        session.sendMessage(messageData, replyHandler: nil, errorHandler: nil)
    }
    
}

