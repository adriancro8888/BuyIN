//
//  SearchViewController.swift
//  BuyIN
//
//  Created by Amr Hossam on 19/03/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    var brandFilter:String?
    var categoryFilter:String?
    var typeFilter:String?
    var tagFilter:String?
    var isFiltered: Bool = false
    var searchQuery: String? {
        didSet {
            applyFiltring()
        }
    }
    private let filterView: FilterContainerView = {
        let view = FilterContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var filteredProducts = [ProductViewModel]()


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    
    private var products: [ProductViewModel] = []
    private var filterViewHeight: CGFloat = 0
    private var heightConstraint: NSLayoutConstraint?
    private var isFilterExpanded: Bool = false
    static func sectionLayoutProvider() -> NSCollectionLayoutSection {
        
        let supplementaryView = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(60)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/2),
                heightDimension: .fractionalHeight(1)
            ))
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(350)
            ),
            subitem: item,
            count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = supplementaryView
        return section
    }
    
    private let collectionView: UICollectionView = {
       
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(
                section: SearchViewController.sectionLayoutProvider()
            ))
        collectionView.register(SearchHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchHeaderCollectionReusableView.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(ProductPreviewCollectionViewCell.self, forCellWithReuseIdentifier: ProductPreviewCollectionViewCell.identifier)
        return collectionView
    }()
   
    private func configureNavbar() {
        title = "Search"
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(didTapDismiss))
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func configureFilterView() {

        view.addSubview(filterView)
        filterView.delegate = self
        heightConstraint = NSLayoutConstraint(item: filterView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 0)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        configureNavbar()
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        configureFilterView()
        configureConstraints()
        fetchProducts()
    }
    
    private func fetchProducts() {
        Client.shared.fetchProducts { [weak self] result in
            guard let result = result else {
                return
            }
            
            self?.products = result.items
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    @objc private func didTapDismiss() {
        dismiss(animated: true)
    }
    

    
    private func configureConstraints() {
        
        guard let heightConstraint = heightConstraint else {
            return
        }

        let collectionViewConstraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let filterViewConstraints = [
            filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            heightConstraint,
        ]
        
        NSLayoutConstraint.activate(collectionViewConstraints)
        NSLayoutConstraint.activate(filterViewConstraints)
    }
    func applyFiltring(){
        self.filteredProducts.removeAll()
        self.filteredProducts.append(contentsOf: self.getFilterdArray(self.products))
        print(self.filteredProducts)
        isFiltered = !isFiltered
        self.collectionView.reloadData()
    }
    
    func getFilterdArray(_ datasource:[ProductViewModel]) -> [ProductViewModel]{
        return datasource.filter({ p in
//             title and descreption Search ========================================
            if let searchString = self.searchQuery {
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
}


extension SearchViewController: UITextFieldDelegate {
 
}


extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltered ? filteredProducts.count : products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductPreviewCollectionViewCell.identifier, for: indexPath) as? ProductPreviewCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = isFiltered ? filteredProducts[indexPath.row] : products[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        filterView.frame.origin.y = -contentOffset + 60
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchHeaderCollectionReusableView.identifier, for: indexPath) as? SearchHeaderCollectionReusableView else {
            return UICollectionReusableView()
        }
        header.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailsViewController()
        vc.product = isFiltered ? filteredProducts[indexPath.row] : products[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: SearchHeaderCollectionReusableViewDelegate {
    func searchHeaderCollectionReusableViewDidStartSearching(_ search: String) {
        searchQuery = search
    }
    
    func searchHeaderCollectionReusableViewDidTapFilter() {

        guard let heightConstraint  = heightConstraint else {
            return
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) { [weak self] in
            heightConstraint.constant = self!.isFilterExpanded ? 0 : 60
            self!.view.layoutIfNeeded()

        } completion: { [weak self] _ in
            self?.isFilterExpanded = !self!.isFilterExpanded
        }
    }
}

extension SearchViewController: FilterContainerViewDelegate {
    func filterContainerViewDidReceiveAction(_ action: UIAction, type: String) {
        switch type {
        case "Brand":
            brandFilter = action.title
            applyFiltring()
            
        case "Category":
            categoryFilter = action.title
            applyFiltring()

        case "Tag":
            tagFilter = action.title
            applyFiltring()

        case "Type":
            typeFilter = action.title
            applyFiltring()

        default:
            break
        }
    }
}
