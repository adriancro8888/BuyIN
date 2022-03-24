

import UIKit

extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>() -> T {
        
        let viewController = self.instantiateViewController(withIdentifier: T.className)
        guard let typedViewController = viewController as? T else {
            fatalError("Unable to cast view controller of type (\(type(of: viewController))) to (\(T.className))")
        }
        return typedViewController
    }
    
    
    
    
}

let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

extension UIViewController {
   
   static func instantiateFromNib<T:UIViewController>() -> T {
        
        let viewController = T(nibName: T.className, bundle: nil) 
        return viewController
    }
    
    static func instantiateFromMainStoryboard<T:UIViewController>() -> T{
        
        let viewController: T = mainStoryboard.instantiateViewController()
        return viewController;
    }
}
