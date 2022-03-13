

import Foundation
import Buy

final class CheckoutViewModel: ViewModel {
    
    typealias ModelType = Storefront.Checkout
    
    let model:  ModelType
    
    enum PaymentType: String {
        case applePay   = "apple_pay"
        case creditCard = "credit_card"
    }
    
    let id:               String
    let ready:            Bool
    let requiresShipping: Bool
    let taxesIncluded:    Bool
    let shippingAddress:  AddressViewModel?
    let shippingRate:     ShippingRateViewModel?
    
    let note:             String?
    let webURL:           URL
    
    let giftCards:        [GiftCardViewModel]
    let lineItems:        [LineItemViewModel]
    let currencyCode:     String
    let subtotalPrice:    Decimal
    let totalTax:         Decimal
    let totalDuties:      Decimal?
    let totalPrice:       Decimal
    let paymentDue:       Decimal
    
    let shippingDiscountName:   String
    let totalShippingDiscounts: Decimal
    
    let lineItemDiscountName:   String
    let totalLineItemDiscounts: Decimal
    let totalDiscounts:         Decimal
    
    let shippingDiscountAllocations: [DiscountAllocationViewModel]
    
    // ----------------------------------
    //  MARK: - Init -
    //
    required init(from model: ModelType) {
        self.model            = model
        
        self.id               = model.id.rawValue
        self.ready            = model.ready
        self.requiresShipping = model.requiresShipping
        self.taxesIncluded    = model.taxesIncluded
        self.shippingAddress  = model.shippingAddress?.viewModel
        self.shippingRate     = model.shippingLine?.viewModel
        
        self.note             = model.note
        self.webURL           = model.webUrl
        
        self.giftCards        = model.appliedGiftCards.viewModels
        self.lineItems        = model.lineItems.edges.viewModels
        self.currencyCode     = model.currencyCode.rawValue
        self.subtotalPrice    = model.subtotalPriceV2.amount
        self.totalTax         = model.totalTaxV2.amount
        self.totalDuties      = model.totalDuties?.amount
        self.totalPrice       = model.totalPriceV2.amount
        self.paymentDue       = model.paymentDueV2.amount
        
        self.shippingDiscountAllocations = model.shippingDiscountAllocations.viewModels

        self.shippingDiscountName   = self.shippingDiscountAllocations.aggregateName
        self.totalShippingDiscounts = self.shippingDiscountAllocations.totalDiscount
        
        let lineItemAllocations     = self.lineItems.flatMap { $0.discountAllocations }
        self.lineItemDiscountName   = lineItemAllocations.aggregateName
        self.totalLineItemDiscounts = lineItemAllocations.totalDiscount
        
        self.totalDiscounts         = self.totalShippingDiscounts + self.totalLineItemDiscounts
    }
}

extension Storefront.Checkout: ViewModeling {
    typealias ViewModelType = CheckoutViewModel
}
