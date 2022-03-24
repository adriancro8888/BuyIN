//////
//////  CategoriesViewController.swift
//////  BuyIN
//////
//////  Created by apple on 3/10/22.
//////
////
////import UIKit
////private let reuseIdentifier = "cell"
////class CategoriesViewController: UIViewController {
////
//////
//////    var searchString : String? = nil;
////    @IBOutlet weak var categoryNameLable: UILabel!
////
//
//import UIKit
//import Reachability
//private let reuseIdentifier = "cell"
//class CategoriesViewController: UIViewController {
//
//    
//    var searchString : String? = nil;
//    @IBOutlet weak var categoryNameLable: UILabel!
//    
//    @IBOutlet weak var productsCollectonView: StorefrontCollectionView!
//    
//    @IBOutlet weak var catiogriesCollectionView: StorefrontCollectionView!
//    
//    fileprivate var collections: PageableArray<CollectionViewModel>!
//    fileprivate var selectedCollection:  CollectionViewModel?
//    fileprivate var products: PageableArray<ProductViewModel>!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.configureCollectionView()
//        self.fetchCollections()
//    }
//    private func configureCollectionView() {
//        
//        self.productsCollectonView.paginationDelegate = self
//        self.catiogriesCollectionView.paginationDelegate = self
//        catiogriesCollectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil),
//                                          forCellWithReuseIdentifier:reuseIdentifier)
//        productsCollectonView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil),
//                                          forCellWithReuseIdentifier:reuseIdentifier)
//                                           
//                                              
////        if self.traitCollection.forceTouchCapability == .available {
////            self.registerForPreviewing(with: self, sourceView: self.catiogriesCollectionView)
////        }
////    }
////
////    fileprivate func fetchCollections(after cursor: String? = nil) {
////
////
////        Client.shared.fetchCollections(ofType:CollectionType.category, after: cursor ) { collections in
////            if let collections = collections {
////                self.collections = collections
////                self.catiogriesCollectionView.reloadData()
////                if collections.items.count > 0{
////                    self.collectionView(self.catiogriesCollectionView, didSelectItemAt : IndexPath(row: 0, section: 0))
////                }
////            }
////        }
////    }
////
////    // TODO : will be removed this is JUST FOR TESTING
////    @IBAction func tempActionForSingup(_ sender: Any) {
////
////      //  let view = CreateNewCustomerViewController(nibName: "CreateNewCustomerViewController", bundle: nil)
////
////
//////        let coordinator: CustomerCoordinator = CustomerCoordinator.instantiateFromNib()
//////        self.present(coordinator, animated: true, completion: nil)
////
////
////        let view : CartViewController = CartViewController.instantiateFromNib()
////        view.modalPresentationStyle = .fullScreen;
////        view.modalTransitionStyle = .crossDissolve;
////        self.present(view, animated: true, completion: nil)
////    }
////}
////
////
////
////// ----------------------------------
//////  MARK: - StorefrontTableViewDelegate -
//////
////extension CategoriesViewController: StorefrontCollectionViewDelegate {
////    func collectionViewShouldBeginPaging(_ collectionView: StorefrontCollectionView) -> Bool {
////
////        if collectionView == catiogriesCollectionView {
////            return self.collections?.hasNextPage ?? false
////        }
////        else if collectionView == productsCollectonView {
////            return self.products?.hasNextPage ?? false
////        }
////        return false;
////    }
////
////    func collectionViewWillBeginPaging(_ collectionView: StorefrontCollectionView) {
////
////        if collectionView == catiogriesCollectionView {
////            if let collections = self.collections,
////               let lastCollection = collections.items.last {
////                Client.shared.fetchCollections(ofType: .sales, after: lastCollection.cursor) { collections in
////                    if let collections = collections {
////
////                        self.collections.appendPage(from: collections)
////
////                        self.catiogriesCollectionView.reloadData()
////                        self.catiogriesCollectionView.completePaging()
////                    }
////                }
////            }
////        }else if collectionView == productsCollectonView {
////            if  let products = self.products,
////                let lastProduct = products.items.last,
////                let collection = self.selectedCollection{
////
////                Client.shared.fetchProducts(in: collection, after: lastProduct.cursor) { products in
////                    if let products = products {
////                        self.products.appendPage(from: products)
////                        self.productsCollectonView.reloadData()
////                        self.productsCollectonView.completePaging()
////                    }
////                }
////            }
////        }
////    }
////
////    func collectionViewDidCompletePaging(_ collectionView: StorefrontCollectionView) {
////
////    }
////
////
////}
////
////
////
//// ----------------------------------
////  MARK: - UICollectionViewDataSource -
////
////extension CategoriesViewController: UICollectionViewDataSource {
////
////    // ----------------------------------
////    //  MARK: - Data -
////    //
////    private func numberOfSections(in tableView: UITableView) -> Int {
////       // return self.collections?.items.count ?? 0
////        return 1
////    }
////
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        if collectionView == catiogriesCollectionView {
////            return self.collections?.items.count ?? 0
////        }else  if collectionView == productsCollectonView {
////            return self.products?.items.count ?? 0
////        }
////
////        return 0
////    }
////
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////
////        let cell       = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
////
////        if collectionView == catiogriesCollectionView{
////            let categoryCell = cell as! CategoriesCollectionViewCell
////            let collection = self.collections.items[indexPath.item]
////            categoryCell.configureFrom(collection)
////        }
////        else if collectionView == productsCollectonView{
////            let productCell = cell as! ProductCollectionViewCell
////            let product = self.products.items[indexPath.item]
////            productCell.configureFrom(product)
////        }
////
////
////        return cell
////    }
////}
////// ----------------------------------
//////  MARK: - UICollectionViewDelegate -
//////
////extension CategoriesViewController :UICollectionViewDelegate{
////
////    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        if collectionView == catiogriesCollectionView {
////            let collection = self.collections.items[indexPath.item]
////            selectedCollection = collection
////            categoryNameLable.text = collection.title;
////            Client.shared.fetchProducts(in: collection) { products in
////                if let products = products {
////                    self.products = products
////                    self.productsCollectonView.reloadData()
////                }
////            }
////
////
////
////        }
////        else if collectionView == productsCollectonView{
//////            let newViewController = ProductsViewController(nibName: "ProductsViewController", bundle: nil)
//////            let collection = self.selectedCollection!
//////            newViewController.selectedCollection = collection
//////
////
////            // Present View "Modally"
////         //   self.present(newViewController, animated: true, completion: nil)
////
////
////            //Test Add product to cart
////
//////            let product = self.products.items[indexPath.item]
//////            let item = CartItem(product: product, variant: product.variants.items[0])
//////            CartController.shared.add(item)
////
////
////            let product = self.products.items[indexPath.item]
////            let item = CartItem(product: product, variant: product.variants.items[0])
////            WishlistController.shared.add(item)
////
////
////        }
////    }
////
////}
////
////
//// ----------------------------------
////  MARK: - UICollectionViewDelegate -
////
////extension CategoriesViewController :UICollectionViewDelegateFlowLayout{
////
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////
////
////        var width =  collectionView.frame.width  ;
////        var height =  collectionView.frame.height  ;
////
////        if collectionView == catiogriesCollectionView {
////            width = width / 2.5
////            height = height/1.2
////            if collectionView.frame.width > 1100 {
////                width = collectionView.frame.width / 4.0
////            }else if collectionView.frame.width > 500 {
////                width = collectionView.frame.width / 3.0
////            }
////            return CGSize(width: width, height: height)
////
////        }else if collectionView == productsCollectonView {
////            width = collectionView.frame.width / 2.2
////            height = height/3
////
////            if collectionView.frame.width > 1100 {
////                width = collectionView.frame.width / 4.25
////            }else if collectionView.frame.width > 500 {
////                width = collectionView.frame.width / 3.2
////            }
////
////            return CGSize(width: width, height: height)
////        }
////        return CGSize(width: width, height: width)
////    }
////
////}
////// ----------------------------------
//////  MARK: - UISearchBarDelegate -
//////
////
////
////
////
////extension CategoriesViewController : UISearchBarDelegate{
////
////    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
////        searchString = searchText;
////        self.fetchCollections();
////
////    }
////
////}
