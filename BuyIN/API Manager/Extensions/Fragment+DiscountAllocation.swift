 

import Buy

extension Storefront.DiscountAllocationQuery {
    
    @discardableResult
    func fragmentForDiscountAllocation() -> Storefront.DiscountAllocationQuery { return self
        .allocatedAmount { $0
            .amount()
            .currencyCode()
        }
        .discountApplication { $0
            .fragmentForDiscountApplication()
        }
    }
}
