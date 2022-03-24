//
//  ProductViewModel.swift
//  Storefront
//
//  Created by Shopify.
//  Copyright (c) 2017 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import Buy

final class ProductViewModel: ViewModel {
   
    
    typealias ModelType = Storefront.ProductEdge
    
    var model:    ModelType
    var cursor:   String!
    
    let id:       String
    let title:    String
    let summary:  String
    let price:    String
    let vendor:    String
    let type:    String
    let images:   PageableArray<ImageViewModel>
    let variants: PageableArray<VariantViewModel>
    
    
    // Request on demand only (must be inclouded in query )
    var collections: PageableArray<CollectionViewModel> { get {
      return PageableArray(
                   with:     model.node.collections.edges,
                   pageInfo: model.node.collections.pageInfo
               )
        }
    }
    let tags:[String]
    // ----------------------------------
    //  MARK: - Init -
    //
    
//      init(from product: Storefront.Product) {
////        self.model    = model
////        self.cursor   = model.cursor
////
//        let variants = product.variants.edges.viewModels.sorted {
//            $0.price < $1.price
//        }
//
//        let lowestPrice = variants.first?.price
//
//        self.id       = product.id.rawValue
//        self.title    = product.title
//        self.vendor   = product.vendor
//        self.summary  = product.description
//        self.type = product.productType
//        self.price    = lowestPrice == nil ? "No price" : Currency.stringFrom(lowestPrice!)
//
//        self.images   = PageableArray(
//            with:     product.images.edges,
//            pageInfo: product.images.pageInfo
//        )
//
//        self.variants = PageableArray(
//            with:     product.variants.edges,
//            pageInfo: product.variants.pageInfo
//        )
//
////        self.collections = PageableArray(
////            with:     model.node.collections.edges,
////            pageInfo: model.node.collections.pageInfo
////        )
//        self.tags = product.tags
//        let dix : [String : Any] = [:]
//        do {
//              let edge = try Storefront.ProductEdge(fields: dix)
//
//          }
//
//
//
//    }
    
    




    required init(from model: ModelType) {
        self.model    = model
        self.cursor   = model.cursor
        
        let variants = model.node.variants.edges.viewModels.sorted {
            $0.price < $1.price
        }
        
        let lowestPrice = variants.first?.price
        
        self.id       = model.node.id.rawValue
        self.title    = model.node.title
        self.vendor    = model.node.vendor
        self.summary  = model.node.description
        self.type = model.node.productType
        self.price    = lowestPrice == nil ? "No price" : Currency.stringFrom(lowestPrice!)
        
        self.images   = PageableArray(
            with:     model.node.images.edges,
            pageInfo: model.node.images.pageInfo
        )
        
        self.variants = PageableArray(
            with:     model.node.variants.edges,
            pageInfo: model.node.variants.pageInfo
        )
        
//        self.collections = PageableArray(
//            with:     model.node.collections.edges,
//            pageInfo: model.node.collections.pageInfo
//        )
        self.tags = model.node.tags
        
    }
}

extension Storefront.ProductEdge: ViewModeling {
    typealias ViewModelType = ProductViewModel
}

