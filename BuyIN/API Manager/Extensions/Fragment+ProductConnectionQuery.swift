 

import Buy

extension Storefront.ProductConnectionQuery {
    
    @discardableResult
    func fragmentForStandardProduct() -> Storefront.ProductConnectionQuery { return self
        .pageInfo { $0
            .hasNextPage()
        }
        .edges { $0
            .cursor()
            .node { $0 
            .fragmentForStandardProduct()
            }
        }
    }
    
    
}

extension Storefront.ProductQuery {
    
    
    @discardableResult
    func fragmentForStandardProduct() -> Storefront.ProductQuery { return self
        
        
            .id()
            .title()
            .description()
            .vendor()
            .productType()
            .variants(first: 250) { $0
            .fragmentForStandardVariant()
            }
            .images(first: 250) { $0
            .fragmentForStandardProductImage()
            }
        
    }
}

