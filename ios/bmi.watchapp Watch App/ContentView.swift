import SwiftUI
import Foundation
import WatchConnectivity

struct ContentView: View {
    
    @ObservedObject var viewModel: WatchViewModel = WatchViewModel()
    var body: some View {
        VStack {
            Text("Happiness metric")
                .fontWeight(.heavy)
            
            Text("BMI")
            
            TextField("BMI", text: $viewModel.bmi)
            
            //Text("Happiness")
            /*
             Picker("Happiness", selection: $viewModel.happiness) {
             ForEach (HappinessLevel.allCases) { level in
             Text(level.rawValue.capitalized)
             }
             }
             */
            /*
             Button(action: {
             viewModel.sendDataMessage(for: .sendHappinessToFlutter, data: ["happibess": viewModel.happiness])
             }) {
             Text("Feel Lucky?")
             }
             */
            //}
            //.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum HappinessLevel: String, CaseIterable, Identifiable {
    case low, normal, high
    var id: Self { self }
}

class WatchViewModel: NSObject, ObservableObject {
    var session: WCSession

    @Published var bmi = ""
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
                self.bmi = (message["data"] as? String) ?? ""
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
