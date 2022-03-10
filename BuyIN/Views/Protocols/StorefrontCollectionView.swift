//
//  StorefrontCollectionView.swift
//  BuyIN
//
//  Created by Akram Elhayani on 10/03/2022.
//

import UIKit

protocol StorefrontCollectionViewDelegate: AnyObject {
    func collectionViewShouldBeginPaging(_ collectionView: StorefrontCollectionView) -> Bool
    func collectionViewWillBeginPaging(_ collectionView: StorefrontCollectionView)
    func collectionViewDidCompletePaging(_ collectionView: StorefrontCollectionView)
}

class StorefrontCollectionView: UICollectionView, Paginating {
    
    @IBInspectable private dynamic var cellNibName: String?
    
    weak var paginationDelegate: StorefrontCollectionViewDelegate?
    
    var paginationThreshold: CGFloat             = 500.0
    var paginationState:     PaginationState     = .ready
    var paginationDirection: PaginationDirection = .verical
    
    // ----------------------------------
    //  MARK: - Awake -
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let className = self.value(forKey: "cellNibName") as? String {
            self.register(UINib(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
        }
    }
    
    // ----------------------------------
    //  MARK: - Layout -
    //
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.trackPaging()
    }
    
    func shouldBeginPaging() -> Bool {
        return self.paginationDelegate?.collectionViewShouldBeginPaging(self) ?? false
    }
    
    func willBeginPaging() {
        print("Paging collection view...")
        self.paginationDelegate?.collectionViewWillBeginPaging(self)
    }
    
    func didCompletePaging() {
        print("Finished paging collection view.")
        self.paginationDelegate?.collectionViewDidCompletePaging(self)
    }
}
