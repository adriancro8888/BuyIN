 
import UIKit

extension UIImageView {
    
    typealias Completion = () -> Void
    
    private struct Key {
        static var image = "com.storefront.image.key"
    }
    
    private var currentTask: URLSessionDataTask? {
        get {
            return objc_getAssociatedObject(self, &Key.image) as? URLSessionDataTask
        }
        set {
            objc_setAssociatedObject(self, &Key.image, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setImageFrom(_ url: URL?, placeholder: UIImage? = nil, completion: Completion? = nil) {
        
        self.currentTask?.cancel()
        
        /* ---------------------------------
         ** If the url is provided, kick off
         ** the image request and update the
         ** current data task.
         */
        if let url = url {
            
            if let cachedImage = ImageCache.shared.imageFor(url) {
                self.image = cachedImage
            } else {
                self.image = placeholder
            }
            
            self.currentTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let data = data, let image = UIImage(data: data) {
                    
                    ImageCache.shared.set(image, for: url)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
            self.currentTask?.resume()
            
        } else {
            self.image       = placeholder
            self.currentTask = nil
        }
    }
}

// ----------------------------------
//  MARK: - Image Cache -
//
private class ImageCache: NSCache<NSString, UIImage> {
    
    static let shared = ImageCache()
    
    func set(_ image: UIImage, for url: URL) {
        self.setObject(image, forKey: url.absoluteString as NSString)
    }
    
    func imageFor(_ url: URL?) -> UIImage? {
        guard let url = url else {
            return nil
        }
        return self.object(forKey: url.absoluteString as NSString)
    }
}
