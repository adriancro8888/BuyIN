//
//  ProductsViewController.swift
//  BuyIN
//
//  Created by Akram Elhayani on 16/03/2022.
//

import UIKit

class ProductsViewController: UIViewController {
    var collection :CollectionViewModel?
    var products: PageableArray<ProductViewModel>!
    var filterdProducts=[ProductViewModel]()
    var searchString:String?=nil
    var brandFilter:String?
    var categoryFilter:String?
    var typeFilter:String?
    var tagFilter:String?
    
    
    let filterView:FilterViewController  = FilterViewController()
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var productCollectionView: StorefrontCollectionView!
    
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var filterBannerView: UIView!
    @IBOutlet weak var filterBannerCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        filterButton.setTitle("", for: .normal)
        self.productCollectionView .paginationDelegate = self ;
        let nib = UINib(nibName: "ProductsCellCollectionViewCell", bundle: nil)
        productCollectionView.register(nib, forCellWithReuseIdentifier: "ProductsCellCollectionViewCell")
        
        let nib2 = UINib(nibName: "LoadingCollectionViewCell", bundle: nil)
        productCollectionView.register(nib2, forCellWithReuseIdentifier: "LoadingCollectionViewCell")
        
        
        
        if (collection == nil) {
            Client.shared.fetchCollections(ofType: .all) { responce in
                if let responce = responce {
                    if responce.items.count > 0 {
                        self.collection = responce.items[0]
                        self.fetchProducts()
                    }
                    
                }
            }
        }else{
            self.fetchProducts()
        }
        
        
        self.addChild(filterView)
        self.view.addSubview(filterView.view)
        filterView.productsView = self ;
        filterView.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        filterView.didMove(toParent: self)
        view.bringSubviewToFront(filterView.view)
    }
    
    
    
    
    fileprivate func fetchProducts(after cursor: String? = nil
                                   ,completion: (() -> Void)? = nil) {
        
        Client.shared.fetchProducts(limit: 25, after: cursor) {  productsResult in
            if let productsResult = productsResult
            {
                if let currentCursor = self.products?.items.last?.cursor
                    ,let incomingCursor = productsResult.items.last?.cursor {
                    
                    if incomingCursor == currentCursor {
                        // print("Cursors are the same ====================")
                    }
                    else {
                        self.filterdProducts.append(contentsOf: self.getFilterdArray(productsResult.items))
                        
                    }
                    
                }
                if   cursor != nil {
                    self.products.appendPage(from: productsResult)
                    
                }else{
                    self.products = productsResult;
                    self.filterdProducts .removeAll()
                    self.filterdProducts.append(contentsOf: self.getFilterdArray(productsResult.items))
                    
                }
            }
            
            self.productCollectionView.reloadData()
            if let completion = completion {
                completion()
            }
            
        }
    }
    func applyFiltring(){
        self.filterdProducts .removeAll()
        self.filterdProducts.append(contentsOf: self.getFilterdArray(self.products.items))
        self.productCollectionView.reloadData()
    }
    
    func getFilterdArray(_ datasource:[ProductViewModel]) -> [ProductViewModel]{
        
        return datasource.filter({ p in
            
            // title and descreption Search ========================================
            if let searchString = searchString {
                if p.title.range(of: searchString , options: .caseInsensitive) == nil &&  p.model.node.description.range(of: searchString , options: .caseInsensitive) == nil{
                    return false
                }
            }
            
            
            
            //   print("barnd text : \(self.brandFilter)")
            // brand ========================================
            if let brandFilter = self.brandFilter {
                if  brandFilter.isEmpty == false && p.vendor != brandFilter{
                    return false
                }
            }
            
            // type ========================================
            if let typeFilter = self.typeFilter {
                if p.type != typeFilter{
                    return false
                }
            }
            // tag ========================================
            if let tagFilter = self.tagFilter {
                if !p.tags.contains(where: {$0 == tagFilter}){
                    return false
                }
            }
            // Category ========================================
            if let categoryFilter = self.categoryFilter {
                if !p.collections.items.contains  (where: {$0.title == categoryFilter}){
                    return false
                }
            }
            return true ;
        })
    }
    
    
    @IBAction func filterButtonClicked(_ sender: Any) {
        
        //        UIView.animate(withDuration: 1.30) {
        //            self.filterView.view.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        //        }
        
        // filterView.view.isHidden = !filterView.view.isHidden
        filterView.showViewAnimated()
    }
    
    
    
}

extension ProductsViewController: StorefrontCollectionViewDelegate {
    
    func collectionViewShouldBeginPaging(_ collectionView: StorefrontCollectionView) -> Bool {
        
        return self.products?.hasNextPage ?? false
    }
    
    func collectionViewWillBeginPaging(_ collectionView: StorefrontCollectionView) {
        if collectionView == productCollectionView {
            if  let products = self.products,
                let lastProduct = products.items.last {
                self.fetchProducts(after: lastProduct.cursor) {
                    self.productCollectionView.completePaging()
                }
            }
        }
    }
    
    func collectionViewDidCompletePaging(_ collectionView: StorefrontCollectionView) {
        
        
    }
}

extension ProductsViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let result = (self.products?.hasNextPage ?? false) ? 1 : 0
        if ( self.filterdProducts.count == 0 && (self.products?.hasNextPage ?? false)){
            if  let lastProduct = self.products?.items.last {
                self.fetchProducts(after: lastProduct.cursor)
            }
        }
        return self.filterdProducts.count + result
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item >=  self.filterdProducts.count{
            let loadingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCollectionViewCell", for: indexPath)
            return loadingCell
        }else{
            
            
            let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCellCollectionViewCell", for: indexPath)as! ProductsCellCollectionViewCell
            let product = self.filterdProducts[indexPath.row]
            productCell.configureFrom(product)
            return productCell
            
        }
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
        
        return CGSize(width: width, height: height)
    }
}
extension ProductsViewController :UISearchBarDelegate{
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            searchString = nil
            view.endEditing(true)
        }
        else{
            searchString = searchBar.text;
        }
        self.applyFiltring()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
}

