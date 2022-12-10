import Foundation
import WatchConnectivity

class SyncService : NSObject, WCSessionDelegate {
    
    
    private var session: WCSession = .default

    init(session: WCSession = .default) {
        
        
        super.init()
        self.session = session
        self.session.delegate = self
        self.connect()
        //print(self.session.isReachable)
        
       
    }
    
    func connect() {
        guard WCSession.isSupported() else {
            print("WCSession is not supported")
            return
        }
        
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
        
    }

    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) { }
    
    func sessionDidDeactivate(_ session: WCSession) { }
    #endif
    
        
     //   func sendMessage(_ key: String, _ message: String, _ errorHandler: ((Error) -> Void)?) {
        //    if session.isReachable {
        //        session.sendMessage([key : message], replyHandler: nil) { (error) in
         //           print(error.localizedDescription)
         //           if let errorHandler = errorHandler {
           ///             errorHandler(error)
            //        }
        //        }
       //     }
   //     }
        
    

        
        
    }

    
    

