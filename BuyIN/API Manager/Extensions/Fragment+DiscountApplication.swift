 

import Buy

extension Storefront.DiscountApplicationQuery {
    
    @discardableResult
    func fragmentForDiscountApplication() -> Storefront.DiscountApplicationQuery { return self
        .onDiscountCodeApplication { $0
            .applicable()
            .code()
        }
        .onManualDiscountApplication { $0
            .title()
        }
        .onScriptDiscountApplication { $0
            .title()
        }
    }
}
