 

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
    
    
    @discardableResult
    func fragmentForStandardProductWithCollection() -> Storefront.ProductConnectionQuery { return self
        .pageInfo { $0
            .hasNextPage()
        }
        .edges { $0
            .cursor()
            .node { $0
            .fragmentForStandardProductWithCollections()
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
            .tags()
            .variants(first: 250) { $0
            .fragmentForStandardVariant()
            }
            .images(first: 250) { $0
            .fragmentForStandardProductImage()
            }
    }
    
    
    @discardableResult
    func fragmentForStandardProductWithCollections() -> Storefront.ProductQuery { return self
        
        
            .id()
            .title()
            .description()
            .vendor()
            .productType()
            .tags()
            .variants(first: 250) { $0
            .fragmentForStandardVariant()
            }
            .images(first: 250) { $0
            .fragmentForStandardProductImage()
            }
            .collections(first:250){ $0
                    .pageInfo { $0
                        .hasNextPage()
                    }
                    .edges { $0
                        .cursor()
                        .node { $0
                            .id()
                            .title()
                            .description()
                            .image( ) { $0
                                .url()
                            }
                            .products(first: Int32(1)) { $0
                                .fragmentForStandardProduct()
                            }

                        }

            }
        
            }
    }
    
}

