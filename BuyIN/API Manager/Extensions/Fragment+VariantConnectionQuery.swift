 

import Buy

extension Storefront.ProductVariantConnectionQuery {
    
    @discardableResult
    func fragmentForStandardVariant() -> Storefront.ProductVariantConnectionQuery { return self
        .pageInfo { $0
            .hasNextPage()
        }
        .edges { $0
            .cursor()
            .node { $0
                .id()
                .title()
                .priceV2 { $0
                    .amount()
                    .currencyCode()
                }
            }
        }
    }
}
