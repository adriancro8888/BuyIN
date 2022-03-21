 
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
                            .discountedTotalPrice{$0
                                .amount()
                                .currencyCode()
                                
                            }
                            .originalTotalPrice{$0
                                .amount()
                                .currencyCode()
                                
                            }

                            .title()
                            .variant{$0
                                .image{$0
                                    .url()
                                }
                            }
                        }
                    }
                }
            .edited()
            .cancelReason()
                .fulfillmentStatus()
                
                
                
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
                .currentTotalPrice { $0
                    .amount()
                    .currencyCode()
                }
                .currentSubtotalPrice { $0
                    .amount()
                    .currencyCode()
                }
                .originalTotalPrice { $0
                    .amount()
                    .currencyCode()
                }
                .subtotalPriceV2{ $0
                    .amount()
                    .currencyCode()
                }
                .totalPriceV2{ $0
                    .amount()
                    .currencyCode()
                }
                .totalShippingPriceV2{ $0
                    .amount()
                    .currencyCode()
                }
                .totalTaxV2{ $0
                    .amount()
                    .currencyCode()
                }
                .processedAt()
                .shippingAddress{$0
                    .address1()
                    .city()
                    .country()
                    .formatted()
                    .formattedArea()
                    .phone()
                    .province()
                }
                .phone()
            }
        }
    }
}
