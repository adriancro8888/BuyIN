//
//  File.swift
//  BuyIN
//
//  Created by apple on 3/20/22.
//

import Foundation
import Reachability

class NetworkManager: NSObject {
    var reachability : Reachability!
    static let sharedInstance : NetworkManager = NetworkManager()
    
    override init() {
        super .init()
        reachability = try! Reachability()
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
             try reachability.startNotifier()
           }catch{
             print("could not start reachability notifier")
           }
        
        
    }
    @objc func reachabilityChanged(note: Notification) {

      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi:
          print("Reachable via WiFi")
      case .cellular:
          print("Reachable via Cellular")
      case .unavailable:
        print("Network not reachable")

      case .none:
        print("none")
      }
    
}
}
