//
//  ProductsViewController.swift
//  BuyIN
//
//  Created by apple on 3/11/22.
//

import UIKit

class ProductsViewController: UIViewController {

    var searchString : String? = nil;
    

    @IBOutlet weak var productCollectionView: StorefrontCollectionView!
     var collections: PageableArray<CollectionViewModel>!
     var selectedCollection:  CollectionViewModel?
     var products: PageableArray<ProductViewModel>!
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.productCollectionView.paginationDelegate = self
        
        let nib = UINib(nibName: "ProductsCellCollectionViewCell", bundle: nil)
        productCollectionView.register(nib, forCellWithReuseIdentifier: "ProductsCellCollectionViewCell")
        self.fetchProducts()

       
    }

    fileprivate func fetchProducts(after cursor: String? = nil) {
     
                if let collection = self.selectedCollection {
                        Client.shared.fetchProducts(in: collection) { products in
                            if let products = products {
                                self.products = products

                            }
                        }

                    DispatchQueue.main.async {
                        self.productCollectionView.reloadData()
                    }
                  
                }
    }
}
    extension ProductsViewController: StorefrontCollectionViewDelegate {
    func collectionViewShouldBeginPaging(_ collectionView: StorefrontCollectionView) -> Bool {
        
       
         if collectionView == productCollectionView {
            return self.products?.hasNextPage ?? false
        }
        return false;
    }
    
    func collectionViewWillBeginPaging(_ collectionView: StorefrontCollectionView) {
        
      
         if collectionView == productCollectionView {
            if  let products = self.products,
                let lastProduct = products.items.last,
                let collection = self.selectedCollection{
                
                Client.shared.fetchProducts(in: collection, after: lastProduct.cursor) { products in
                    if let products = products {
                        self.products.appendPage(from: products)
                        self.productCollectionView.reloadData()
                        self.productCollectionView.completePaging()
                    }
                }
            }
        }
    }
    
    func collectionViewDidCompletePaging(_ collectionView: StorefrontCollectionView) {
         
    }
    
 
}

extension ProductsViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.products?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCellCollectionViewCell", for: indexPath)as! ProductsCellCollectionViewCell
        let product = products.items[indexPath.row]
        productCell.configureFrom(product)
        return productCell
    }
    
    
}

extension ProductsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width =  collectionView.frame.width
        var height =  collectionView.frame.height
        width = collectionView.frame.width / 2.2
        height = height/3
       
        if collectionView.frame.width > 1100 {
            width = collectionView.frame.width / 4.25
        }else if collectionView.frame.width > 500 {
            width = collectionView.frame.width / 3.2
        }
        print ("collectionView.frame.width \(collectionView.frame.width ) width : \(width)")
        return CGSize(width: width, height: height)
    }
}

