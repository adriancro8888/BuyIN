
import Foundation

/// This class provides insufficient security for
/// storing customer access token and is provided
/// for sample purposes only. All secure credentials
/// should be stored using Keychain.
///
class AccountController {
    
    static let shared = AccountController()
    
    private(set) var accessToken: String?
    
    private let defaults = UserDefaults.standard
    
    // ----------------------------------
    //  MARK: - Init -
    //
    private init() {
        self.loadToken()
    }
    
    // ----------------------------------
    //  MARK: - Management -
    //
    func save(accessToken: String) {
        self.accessToken = accessToken
        self.defaults.set(accessToken, forKey: Key.token)
        self.defaults.synchronize()
    }
    
    func deleteAccessToken() {
        self.accessToken = nil
        self.defaults.removeObject(forKey: Key.token)
        self.defaults.synchronize()
    }
    
    @discardableResult
    func loadToken() -> String? {
       self.accessToken = self.defaults.string(forKey: Key.token)
       // self.accessToken = "Yousra"
        
        return self.accessToken
    }
}

private extension AccountController {
    enum Key {
        static let token = "com.shopify.storefront.customerAccessToken"
    }
}
