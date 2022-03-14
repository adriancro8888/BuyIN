

import Foundation

final class CartItemViewModel: ViewModel {
    typealias ModelType = CartItem
    
    let model: ModelType
    
    let imageURL: URL?
    let title:    String
    let subtitle: String
    let price:    String
    let quantity: Int
    
    var quantityDescription: String {
        return "Quantity: \(model.quantity)"
    }
    
    // ----------------------------------
    //  MARK: - Init -
    //
    required init(from model: ModelType) {
        self.model = model
        
        self.imageURL = model.product.images.items.first?.url
        self.title    = model.product.title
        self.subtitle = model.variant.title
        self.quantity = model.quantity
        self.price    = Currency.stringFrom(model.variant.price * Decimal(model.quantity))
    }
}

extension CartItem: ViewModeling {
    typealias ViewModelType = CartItemViewModel
}
