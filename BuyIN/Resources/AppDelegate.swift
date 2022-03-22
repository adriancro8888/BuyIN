//
//  AppDelegate.swift
//  BuyIN
//
//  Created by apple on 3/10/22.
//

import UIKit
import CoreData


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let window: UIWindow? = nil
  



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


        _ = CartController.shared
        Client.shared.loadBrands()
        Client.shared.loadTags()
        Client.shared.loadTypes()
        Client.shared.loadCategories()
        return true
    }
    
    
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "BuyIN")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
//    @objc func reachabilityStatusChanged(_ notification:Notification){
//        reachability.whenReachable = { reachability in
//            let homeViewController : HomeViewController = HomeViewController.instantiateFromMainStoryboard()
//            self.window?.rootViewController = homeViewController
//            self.window?.makeKeyAndVisible()
//        }
//        reachability.whenUnreachable = { _ in
//            let noInternetViewController : NoInternetViewController = NoInternetViewController.instantiateFromNib()
//            self.window?.rootViewController =  noInternetViewController
//            self.window?.makeKeyAndVisible()
//            let alert = UIAlertController(title: "Disconnected", message: "Mobile is disconnected, please make sure it's connected", preferredStyle: .alert)
//            
//            // Create OK button with action handler
//            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
//                print("Ok button tapped")
//             })
//            
//            //Add OK button to a dialog message
//            alert.addAction(ok)
//            // Present Alert to
//            
//           
//            
//        }
//     }
    

}

