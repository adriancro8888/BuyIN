

import Foundation
extension Notification.Name {
    static let WishlistControllerItemsDidChange = Notification.Name("WishlistController.ItemsDidChange")
}

class WishlistController {
    
    static let shared = WishlistController()
    
    private(set) var items: [CartItem] = []
    
    var subtotal: Decimal {
        return self.items.reduce(0) {
            $0 + $1.variant.price * Decimal($1.quantity)
        }
    }
    
    var itemCount: Int {
        return self.items.reduce(0) {
            $0 + $1.quantity
        }
    }
    
    private let ioQueue    = DispatchQueue(label: "com.storefront.writeQueue")
    private var needsFlush = false
    private var WishlistURL: URL = {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsURL  = URL(fileURLWithPath: documentsPath)
        let WishlistURL       = documentsURL.appendingPathComponent("\(Client.shopDomain)_wishlist.json")
        
        print("Wishlist URL: \(WishlistURL)")
        
        return WishlistURL
    }()
    
    // ----------------------------------
    //  MARK: - Init -
    //
    private init() {
        self.readWishlist { items in
            if let items = items {
                self.items = items
                
                self.postItemsChangedNotification()
            }
        }
    }
    
    // ----------------------------------
    //  MARK: - Notifications -
    //
    private func postItemsChangedNotification() {
        let notification = Notification(name: Notification.Name.WishlistControllerItemsDidChange)
        NotificationQueue.default.enqueue(notification, postingStyle: .asap)
    }
    
    // ----------------------------------
    //  MARK: - IO Management -
    //
    private func setNeedsFlush() {
        if !self.needsFlush {
            self.needsFlush = true
            
            DispatchQueue.main.async(execute: self.flush)
        }
    }
    
    private func flush() {
        let serializedItems = self.items.serialize()
        self.ioQueue.async {
            do {
                let data = try JSONSerialization.data(withJSONObject: serializedItems, options: [])
                try data.write(to: self.WishlistURL, options: [.atomic])
                
                print("Flushed Wishlist to disk.")
                
            } catch let error {
                print("Failed to flush Wishlist to disk: \(error)")
            }
            
            DispatchQueue.main.async {
                self.needsFlush = false
            }
        }
    }
    
    private func readWishlist(completion: @escaping ([CartItem]?) -> Void) {
        self.ioQueue.async {
            do {
                let data            = try Data(contentsOf: self.WishlistURL)
                let serializedItems = try JSONSerialization.jsonObject(with: data, options: [])
                
                let WishlistItems = [CartItem].deserialize(from: serializedItems as! [SerializedRepresentation])
                DispatchQueue.main.async {
                    completion(WishlistItems)
                }
                
            } catch let error {
                print("Failed to load Wishlist from disk: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    // ----------------------------------
    //  MARK: - State Changes -
    //
    private func itemsChanged() {
        self.setNeedsFlush()
        self.postItemsChangedNotification()
    }
    
    // ----------------------------------
    //  MARK: - Item Management -
    //
 
 
    func add(_ cartItem: CartItem) {
        if let _ = self.items.firstIndex(of: cartItem) {
          //  self.items[index].quantity += 1
        } else {
            self.items.append(cartItem)
        }
        
        self.itemsChanged()
    }
    
    func removeAllQuantitiesFor(_ cartItem: CartItem) {
        if let index = self.items.firstIndex(of: cartItem) {
            self.removeAllQuantities(at: index)
        }
    }
    
    func removeAllQuantities(at index: Int) {
        self.items.remove(at: index)
        self.itemsChanged()
    }
    
    func moveToCart(at index: Int) {
        CartController.shared.add(self.items[index])
        self.items.remove(at: index)
        self.itemsChanged()
    }
    
    func emptyWishlist() {
        self.items.removeAll()
        self.itemsChanged()
    }
}
