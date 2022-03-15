

import Foundation


extension Notification.Name {
    static let CartControllerItemsDidChange = Notification.Name("CartController.ItemsDidChange")
}

class CartController {
    
    static let shared = CartController()
    
    private(set) var items: [CartItem] = []
    private(set) var orders: [CartItem] = []  // by yousra

    
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
    private var cartURL: URL = {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsURL  = URL(fileURLWithPath: documentsPath)
        let cartURL       = documentsURL.appendingPathComponent("\(Client.shopDomain).json")
        
        print("Cart URL: \(cartURL)")
        
        return cartURL
    }()
    
    // ----------------------------------
    //  MARK: - Init -
    //
    private init() {
        self.readCart { items in
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
        let notification = Notification(name: Notification.Name.CartControllerItemsDidChange)
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
                try data.write(to: self.cartURL, options: [.atomic])
                
                print("Flushed cart to disk.")
                
            } catch let error {
                print("Failed to flush cart to disk: \(error)")
            }
            
            DispatchQueue.main.async {
                self.needsFlush = false
            }
        }
    }
    
    private func readCart(completion: @escaping ([CartItem]?) -> Void) {
        self.ioQueue.async {
            do {
                let data            = try Data(contentsOf: self.cartURL)
                let serializedItems = try JSONSerialization.jsonObject(with: data, options: [])
                
                let cartItems = [CartItem].deserialize(from: serializedItems as! [SerializedRepresentation])
                DispatchQueue.main.async {
                    completion(cartItems)
                }
                
            } catch let error {
                print("Failed to load cart from disk: \(error)")
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
    func updateQuantity(_ quantity: Int, at index: Int) -> Bool {
        let existingItem = self.items[index]
        
        if existingItem.quantity != quantity {
            existingItem.quantity = quantity
            
            self.itemsChanged()
            return true
        }
        return false
    }
    
    func incrementAt(_ index: Int) {
        let existingItem = self.items[index]
        existingItem.quantity += 1
        
        self.itemsChanged()
    }
    
    func decrementAt(_ index: Int) {
        let existingItem = self.items[index]
        existingItem.quantity -= 1
        
        self.itemsChanged()
    }
    
    func add(_ cartItem: CartItem) {
        if let index = self.items.firstIndex(of: cartItem) {
            self.items[index].quantity += 1
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
    
    func emptyCart() {
       self.orders = items // by Yousra
        print(orders)
        self.items.removeAll()
        self.itemsChanged()
    }
}
