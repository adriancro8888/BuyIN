//
//  APICaller.swift
//  BuyIN
//
//  Created by apple on 3/10/22.
//

import Foundation
import Buy
import Pay

final class Client {
    
    
    
    static let shopDomain = "itiios.myshopify.com"
    static let apiKey     = "f78f765d212201e09cf5b3d6f8020421"
    static let merchantID = "merchant.elhayani.com"
    
    static let imageTransferInput =  Storefront.ImageTransformInput.create( maxWidth: .value(800), maxHeight: .value(800))
//    static let shopDomain = "jets-ismailia.myshopify.com"
//    static let apiKey     = "70adb96961fe55ab1ce308476d536e01"

    static let shared = Client()
    
    private let client: Graph.Client = Graph.Client(shopDomain: Client.shopDomain, apiKey: Client.apiKey, locale:nil)
    
    // ----------------------------------
    //  MARK: - Init -
    //
    private init() {
        self.client.cachePolicy = .cacheFirst(expireIn: 3600)
        
    }
    
    // ----------------------------------
    //  MARK: - Customers -
    //
    
    @discardableResult
    func CreateCustomer(firstName : String , lastName :String , phone:String ,email:String ,password:String , completion: @escaping (Storefront.Customer?,[Storefront.CustomerUserError]? ) -> Void) -> Task {

        let mutation = ClientQuery.mutationForCreatingCustomer(firstName: firstName, lastName: lastName, phone: phone, email: email, password: password)
        
        let task     = self.client.mutateGraphWith(mutation) { (mutation, error) in
            error.debugPrint()

            if let container = mutation?.customerCreate?.customer {
                completion(container,nil)
            } else {
                let errors = mutation?.customerCreate?.customerUserErrors ?? []
                print("Failed to Create customer: \(errors)")
                completion(nil,errors)
            }
        }
        task.resume()
        return task
    }
    @discardableResult
    func resetPassword(withEmail: String , completion: @escaping (_ errorMessage : String?) -> Void) -> Task {
        
        let mutation = ClientQuery.mutationCustomerRecovery(email: withEmail)
        let task     = self.client.mutateGraphWith(mutation) { (mutation, error) in
            error.debugPrint()
            
            if let errors = mutation?.customerRecover?.customerUserErrors {
                if(errors.count>0){
                    completion(errors[0].message)
                }
                else {
                    completion(nil)
                }
                    
            } else {
                completion(nil)
            }
        } 
        task.resume()
        return task
    }

    
    
    @discardableResult
    func login(email: String, password: String, completion: @escaping (String?) -> Void) -> Task {
        
        let mutation = ClientQuery.mutationForLogin(email: email, password: password)
        let task     = self.client.mutateGraphWith(mutation) { (mutation, error) in
            error.debugPrint()
            
            if let container = mutation?.customerAccessTokenCreate?.customerAccessToken {
                completion(container.accessToken)
            } else {
                let errors = mutation?.customerAccessTokenCreate?.customerUserErrors ?? []
                print("Failed to login customer: \(errors)")
                completion(nil)
            }
        }
        task.resume()
        return task
    }
    
    @discardableResult
    func logout(accessToken: String, completion: @escaping (Bool) -> Void) -> Task {
        
        let mutation = ClientQuery.mutationForLogout(accessToken: accessToken)
        let task     = self.client.mutateGraphWith(mutation) { (mutation, error) in
            error.debugPrint()
            
            if let deletedToken = mutation?.customerAccessTokenDelete?.deletedAccessToken {
                completion(deletedToken == accessToken)
            } else {
                let errors = mutation?.customerAccessTokenDelete?.userErrors ?? []
                print("Failed to logout customer: \(errors)")
                completion(false)
            }
        }
        
        task.resume()
        return task
    }
    
    @discardableResult
    func fetchCustomerAndOrders(limit: Int = 25, after cursor: String? = nil, accessToken: String, completion: @escaping ((customer: CustomerViewModel, orders: PageableArray<OrderViewModel>)?) -> Void) -> Task {
        
        let query = ClientQuery.queryForCustomer(limit: limit, after: cursor, accessToken: accessToken)
        let task  = self.client.queryGraphWith(query) { (query, error) in
            error.debugPrint()
            
            if let customer = query?.customer {
                
                let viewModel   = customer.viewModel
                let collections = PageableArray(
                    with:     customer.orders.edges,
                    pageInfo: customer.orders.pageInfo
                )
                completion((viewModel, collections))
            } else {
                print("Failed to load customer and orders: \(String(describing: error))")
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
    // ----------------------------------
    //  MARK: - Shop -
    //
    @discardableResult
    func fetchShopName(completion: @escaping (String?) -> Void) -> Task {
        
        let query = ClientQuery.queryForShopName()
        let task  = self.client.queryGraphWith(query) { (query, error) in
            error.debugPrint()
            
            if let query = query {
                completion(query.shop.name)
            } else {
                print("Failed to fetch shop name: \(String(describing: error))")
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
    @discardableResult
    func fetchShopURL(completion: @escaping (URL?) -> Void) -> Task {
        
        let query = ClientQuery.queryForShopURL()
        let task  = self.client.queryGraphWith(query) { (query, error) in
            error.debugPrint()
            
            if let query = query {
                completion(query.shop.primaryDomain.url)
            } else {
                print("Failed to fetch shop url: \(String(describing: error))")
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
    // ----------------------------------
    //  MARK: - Collections -
    //
    
    @discardableResult
    func fetchCollections(ofType:CollectionType,limit: Int = 25, after cursor: String? = nil, productLimit: Int = 25, productCursor: String? = nil , queryString:String?=nil, completion: @escaping (PageableArray<CollectionViewModel>?) -> Void) -> Task {
        
        let query = ClientQuery.queryForCollections(ofType:ofType, limit: limit,queryString: queryString, after: cursor, productLimit: productLimit, productCursor: productCursor)
        let task  = self.client.queryGraphWith(query) { (query, error) in
            error.debugPrint()
            
            if let query = query {
                let collections = PageableArray(
                    with:     query.collections.edges,
                    pageInfo: query.collections.pageInfo
                )
                completion(collections)
            } else {
                print("Failed to load collections: \(String(describing: error))")
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
    // ----------------------------------
    //  MARK: - Products -
    //
    
    
    @discardableResult
    func fetchProducts(limit: Int = 25, after cursor: String? = nil, withQuery  :String? = nil, completion: @escaping (PageableArray<ProductViewModel>?) -> Void) -> Task {
        
        let query = ClientQuery.queryForProducts(limit: limit, after: cursor,withQuery: withQuery)
        let task  = self.client.queryGraphWith(query) { (query, error) in
            error.debugPrint()
            
            if let query = query {
                
                let products = PageableArray(
                    with:     query.products.edges,
                    pageInfo: query.products.pageInfo
                )
                completion(products)
                
            } else {
                print("Failed to load products : \(String(describing: error))")
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
    
    
    
    @discardableResult
    func fetchProducts(in collection: CollectionViewModel, limit: Int = 25, after cursor: String? = nil, completion: @escaping (PageableArray<ProductViewModel>?) -> Void) -> Task {
        
        let query = ClientQuery.queryForProducts(in: collection, limit: limit, after: cursor)
        let task  = self.client.queryGraphWith(query) { (query, error) in
            error.debugPrint()
            
            if let query = query,
                let collection = query.node as? Storefront.Collection {
                
                let products = PageableArray(
                    with:     collection.products.edges,
                    pageInfo: collection.products.pageInfo
                )
                completion(products)
                
            } else {
                print("Failed to load products in collection (\(collection.model.node.id.rawValue)): \(String(describing: error))")
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
  
    
    @discardableResult
    func fetchProductRecommendation(in product: ProductViewModel, completion: @escaping ([Storefront.Product]?) -> Void) -> Task {
        
        let query = ClientQuery.queryForProductRecommendation(in: product)
        let task  = self.client.queryGraphWith(query) { (query, error) in
            error.debugPrint()
            
            if let query = query,
               let products = query.productRecommendations {
                completion(products)
            } else {
                print("Failed to load product recommendations : \(String(describing: error))")
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }

    func fetchProductBrands( completion: @escaping ([String : [ProductViewModel]]?) -> Void) -> Task {

        let task = fetchProducts { products in
            
            if let products = products?.items {
                let groupByBrand = Dictionary(grouping: products) { $0.vendor }
                completion(groupByBrand)
            
                }
            }
        task.resume()
        return task
        }
    
    @discardableResult
    func fetchTags(completion: @escaping (Storefront.QueryRoot?) -> Void) -> Task {
        
        let query = ClientQuery.queryForTags()
        let task  = self.client.queryGraphWith(query) { (query, error) in
            error.debugPrint()
            
            if let query = query {
                completion(query)
            } else {
                print("Failed to load Tags  : \(String(describing: error))")
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    @discardableResult
    func fetchTypes(completion: @escaping (Storefront.QueryRoot?) -> Void) -> Task {
        
        let query = ClientQuery.queryForTypes()
        let task  = self.client.queryGraphWith(query) { (query, error) in
            error.debugPrint()
            
            if let query = query {
                completion(query)
            } else {
                print("Failed to load Types  : \(String(describing: error))")
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
    
    var Brands = [String]()
    func loadBrands(){
        Client.shared.fetchProductBrands(){productDic in
            if let keys = productDic?.keys{
                self.Brands.removeAll()
                self.Brands.append(contentsOf: keys)
            }
        }
    }
    
    var Categories = [String]()
    func loadCategories(){
        Client.shared.fetchCollections(ofType: .category){collections in
            if let collections = collections{
                self.Categories.removeAll()
                for item in collections.items {
                    self.Categories.append(item.title)
                }
            }
        }
    }
    
    var Tags = [String]()
    func loadTags(){
        Client.shared.fetchTags(){query in
            if let query = query{
                self.Tags.removeAll()
                for item in query.productTags.edges {
                    self.Tags.append(item.node)
                }
            }
        }
    }
    var Types = [String]()
    func loadTypes(){
        Client.shared.fetchTypes(){query in
            if let query = query{
                self.Types.removeAll()
                for item in query.productTypes.edges {
                    self.Types.append(item.node)
                }
            }
        }
    }
    

 

    
    // ----------------------------------
    //  MARK: - Discounts -
    //
    @discardableResult
    func applyDiscount(_ discountCode: String, to checkoutID: String, completion: @escaping (CheckoutViewModel?) -> Void) -> Task {
        let mutation = ClientQuery.mutationForApplyingDiscount(discountCode, to: checkoutID)
        let task     = self.client.mutateGraphWith(mutation) { response, error in
            error.debugPrint()

            completion(response?.checkoutDiscountCodeApplyV2?.checkout?.viewModel)
        }

        task.resume()
        return task
    }

    // ----------------------------------
    //  MARK: - Gift Cards -
    //
    @discardableResult
    func applyGiftCard(_ giftCardCode: String, to checkoutID: String, completion: @escaping (CheckoutViewModel?) -> Void) -> Task {
        let mutation = ClientQuery.mutationForApplyingGiftCard(giftCardCode, to: checkoutID)
        let task     = self.client.mutateGraphWith(mutation) { response, error in
            error.debugPrint()

            completion(response?.checkoutGiftCardsAppend?.checkout?.viewModel)
        }

        task.resume()
        return task
    }

    // ----------------------------------
    //  MARK: - Checkout -
    //
    @discardableResult
    func createCheckout(with cartItems: [CartItem], completion: @escaping (CheckoutViewModel?) -> Void) -> Task {
        let mutation = ClientQuery.mutationForCreateCheckout(with: cartItems)
        let task     = self.client.mutateGraphWith(mutation) { response, error in
            error.debugPrint()

            completion(response?.checkoutCreate?.checkout?.viewModel)
        }

        task.resume()
        return task
    }

    @discardableResult
    func updateCheckout(_ id: String, updatingPartialShippingAddress address: PayPostalAddress, completion: @escaping (CheckoutViewModel?) -> Void) -> Task {
        let mutation = ClientQuery.mutationForUpdateCheckout(id, updatingPartialShippingAddress: address)
        let task     = self.client.mutateGraphWith(mutation) { response, error in
            error.debugPrint()

            if let checkout = response?.checkoutShippingAddressUpdateV2?.checkout,
                let _ = checkout.shippingAddress {
                completion(checkout.viewModel)
            } else {
                completion(nil)
            }
        }

        task.resume()
        return task
    }

    @discardableResult
    func updateCheckout(_ id: String, updatingCompleteShippingAddress address: PayAddress, completion: @escaping (CheckoutViewModel?) -> Void) -> Task {
        let mutation = ClientQuery.mutationForUpdateCheckout(id, updatingCompleteShippingAddress: address)
        let task     = self.client.mutateGraphWith(mutation) { response, error in
            error.debugPrint()

            if let checkout = response?.checkoutShippingAddressUpdateV2?.checkout,
                let _ = checkout.shippingAddress {
                completion(checkout.viewModel)
            } else {
                completion(nil)
            }
        }

        task.resume()
        return task
    }

    @discardableResult
    func updateCheckout(_ id: String, updatingShippingRate shippingRate: PayShippingRate, completion: @escaping (CheckoutViewModel?) -> Void) -> Task {
        let mutation = ClientQuery.mutationForUpdateCheckout(id, updatingShippingRate: shippingRate)
        let task     = self.client.mutateGraphWith(mutation) { response, error in
            error.debugPrint()

            if let checkout = response?.checkoutShippingLineUpdate?.checkout,
                let _ = checkout.shippingLine {
                completion(checkout.viewModel)
            } else {
                completion(nil)
            }
        }

        task.resume()
        return task
    }

    @discardableResult
    func pollForReadyCheckout(_ id: String, completion: @escaping (CheckoutViewModel?) -> Void) -> Task {

        let retry = Graph.RetryHandler<Storefront.QueryRoot>(endurance: .finite(30)) { response, error -> Bool in
            error.debugPrint()
            return (response?.node as? Storefront.Checkout)?.ready ?? false == false
        }

        let query = ClientQuery.queryForCheckout(id)
        let task  = client.queryGraphWith(query, cachePolicy: .networkOnly, retryHandler: retry) { response, error in
            error.debugPrint()

            if let checkout = response?.node as? Storefront.Checkout {
                completion(checkout.viewModel)
            } else {
                completion(nil)
            }
        }

        task.resume()
        return task
    }

    @discardableResult
    func updateCheckout(_ id: String, updatingEmail email: String, completion: @escaping (CheckoutViewModel?) -> Void) -> Task {
        let mutation = ClientQuery.mutationForUpdateCheckout(id, updatingEmail: email)
        let task     = self.client.mutateGraphWith(mutation) { response, error in
            error.debugPrint()

            if let checkout = response?.checkoutEmailUpdateV2?.checkout,
                let _ = checkout.email {
                completion(checkout.viewModel)
            } else {
                completion(nil)
            }
        }

        task.resume()
        return task
    }

    @discardableResult
    func updateCheckout(_ id: String, associatingCustomer accessToken: String, completion: @escaping (CheckoutViewModel?) -> Void) -> Task {

        let mutation = ClientQuery.mutationForUpdateCheckout(id, associatingCustomer: accessToken)
        let task     = self.client.mutateGraphWith(mutation) { (mutation, error) in
            error.debugPrint()

            if let checkout = mutation?.checkoutCustomerAssociateV2?.checkout {
                completion(checkout.viewModel)
            } else {
                completion(nil)
            }
        }

        task.resume()
        return task
    }

    @discardableResult
    func fetchShippingRatesForCheckout(_ id: String, completion: @escaping ((checkout: CheckoutViewModel, rates: [ShippingRateViewModel])?) -> Void) -> Task {

        let retry = Graph.RetryHandler<Storefront.QueryRoot>(endurance: .finite(30)) { response, error -> Bool in
            error.debugPrint()

            if let checkout = response?.node as? Storefront.Checkout {
                return checkout.availableShippingRates?.ready ?? false == false || checkout.ready == false
            } else {
                return false
            }
        }

        let query = ClientQuery.queryShippingRatesForCheckout(id)
        let task  = self.client.queryGraphWith(query, cachePolicy: .networkOnly, retryHandler: retry) { response, error in
            error.debugPrint()

            if let response = response,
                let checkout = response.node as? Storefront.Checkout {
                completion((checkout.viewModel, checkout.availableShippingRates!.shippingRates!.viewModels))
            } else {
                completion(nil)
            }
        }

        task.resume()
        return task
    }

    func completeCheckout(_ checkout: PayCheckout, billingAddress: PayAddress, applePayToken token: String, idempotencyToken: String, completion: @escaping (PaymentViewModel?) -> Void) {

        let mutation = ClientQuery.mutationForCompleteCheckoutUsingApplePay(checkout, billingAddress: billingAddress, token: token, idempotencyToken: idempotencyToken)
        let task     = self.client.mutateGraphWith(mutation) { response, error in
            error.debugPrint()

            if let payment = response?.checkoutCompleteWithTokenizedPaymentV3?.payment {

                print("Payment created, fetching status...")
                self.fetchCompletedPayment(payment.id.rawValue) { paymentViewModel in
                    completion(paymentViewModel)
                }

            } else {
                completion(nil)
            }
        }

        task.resume()
    }

    func fetchCompletedPayment(_ id: String, completion: @escaping (PaymentViewModel?) -> Void) {

        let retry = Graph.RetryHandler<Storefront.QueryRoot>(endurance: .finite(30)) { response, error -> Bool in
            error.debugPrint()

            if let payment = response?.node as? Storefront.Payment {
                print("Payment not ready yet, retrying...")
                return !payment.ready
            } else {
                return false
            }
        }

        let query = ClientQuery.queryForPayment(id)
        let task  = self.client.queryGraphWith(query, retryHandler: retry) { query, error in

            if let payment = query?.node as? Storefront.Payment {
                print("Payment error: \(payment.errorMessage ?? "none")")
                completion(payment.viewModel)
            } else {
                completion(nil)
            }
        }

        task.resume()
    }

    
}

// ----------------------------------
//  MARK: - GraphError -
//
extension Optional where Wrapped == Graph.QueryError {
    
    func debugPrint() {
        switch self {
        case .some(let value):
            print("Graph.QueryError: \(value)")
        case .none:
            break
        }
    }
}
