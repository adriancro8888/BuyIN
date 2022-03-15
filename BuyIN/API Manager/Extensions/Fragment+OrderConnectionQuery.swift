 
import Buy

extension Storefront.OrderConnectionQuery {
    
    @discardableResult
    func fragmentForStandardOrder() -> Storefront.OrderConnectionQuery { return self
        .pageInfo { $0
            .hasNextPage()
        }
        .edges { $0
            .cursor()
            .node { $0
                
            .lineItems(first:250){$0
                    .edges(){$0
                        .node(){$0
                            .currentQuantity()
                            .title()
                        }
                    }
                }
            .edited()
            .cancelReason()
                
                
                
                .id()
                .orderNumber()
                .email()
                .totalPriceV2 { $0
                    .amount()
                    .currencyCode()
                }
                .originalTotalDuties { $0
                    .amount()
                    .currencyCode()
                }
                .currentTotalDuties { $0
                    .amount()
                    .currencyCode()
                }
            }
        }
    }
}
