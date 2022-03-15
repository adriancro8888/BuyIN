 
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
