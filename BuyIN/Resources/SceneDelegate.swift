//
//  SceneDelegate.swift
//  BuyIN
//
//  Created by apple on 3/10/22.
//

import UIKit
import Reachability

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    let reachability = try! Reachability()
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)


        
   
//        let homeVC : UITabBarController = UITabBarController.instantiateFromMainStoryboard()
//        let navigation = UINavigationController(rootViewController: homeVC)
//        window.rootViewController = navigation
//        self.window = window
//        window.makeKeyAndVisible()
//        
        if let _ = AccountController.shared.accessToken
        {
             let homeVC : UITabBarController = UITabBarController.instantiateFromMainStoryboard()
             let navigation = UINavigationController(rootViewController: homeVC)
             window.rootViewController = navigation
             self.window = window
             window.makeKeyAndVisible()
        }
        else {

            let onboardingVC : WelcomingViewController =
            WelcomingViewController()
            self.window?.rootViewController = onboardingVC
            self.window?.makeKeyAndVisible()
        }

        return
        
        
 
    }
//    @objc func reachabilityStatusChanged(_ notification:Notification){
//        reachability.whenReachable = { reachability in
//            let homeViewController : HomeViewController = HomeViewController.instantiateFromMainStoryboard()
//            self.window?.rootViewController = homeViewController
//            self.window?.makeKeyAndVisible()
//            print("yousra")
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
//           // self.present(alert, animated: true, completion: nil)
//            print("essoo")
//
//
//
//        }
//     }
}

func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}

func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}

func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}

func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}

func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
    
    // Save changes in the application's managed object context when the application transitions to the background.
    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
}





