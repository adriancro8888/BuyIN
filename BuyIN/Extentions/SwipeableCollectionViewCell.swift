//
//import UIKit
//
//protocol SwipeableCollectionViewCellDelegate: AnyObject {
//    func visibleContainerViewTapped(inCell cell: UICollectionViewCell)
//    func hiddenContainerViewTapped(inCell cell: UICollectionViewCell)
//}
//
//class SwipeableCollectionViewCell: UICollectionViewCell {
//
//    // MARK: Properties
//
//    private let scrollView: UIScrollView = {
//        let scrollView = UIScrollView(frame: .zero)
//        scrollView.isPagingEnabled = true
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.showsHorizontalScrollIndicator = false
//        return scrollView
//    }()
//
//    let visibleContainerView = UIView()
//    let hiddenContainerView = UIView()
//
//    weak var swipDelegate: SwipeableCollectionViewCellDelegate?
//
//    // MARK: Initializers
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupSubviews()
//        setupGestureRecognizer()
//    }
//
//
//
//    private func setupSubviews() {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.distribution = .fillEqually
//        stackView.addArrangedSubview(visibleContainerView)
//        stackView.addArrangedSubview(hiddenContainerView)
//
//        addSubview(scrollView)
//        scrollView.pinEdgesToSuperView()
//        scrollView.addSubview(stackView)
//        stackView.pinEdgesToSuperView()
//        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
//        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 2).isActive = true
//    }
//
//    private func setupGestureRecognizer() {
//        let hiddenContainerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hiddenContainerViewTapped))
//        hiddenContainerView.addGestureRecognizer(hiddenContainerTapGestureRecognizer)
//
//        let visibleContainerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(visibleContainerViewTapped))
//        visibleContainerView.addGestureRecognizer(visibleContainerTapGestureRecognizer)
//
//    }
//
//    @objc private func visibleContainerViewTapped() {
//        swipDelegate?.visibleContainerViewTapped(inCell: self)
//    }
//
//    @objc private func hiddenContainerViewTapped() {
//        swipDelegate?.hiddenContainerViewTapped(inCell: self)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        // when the orientation changes and the cell is open -> update the content offset for the new cell width
//        if scrollView.contentOffset.x > 0 {
//            scrollView.contentOffset.x = scrollView.frame.width
//        }
//    }
//}
//extension UIView {
//
//    func pinEdgesToSuperView() {
//        guard let superView = superview else { return }
//        translatesAutoresizingMaskIntoConstraints = false
//        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
//        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
//        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
//        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
//    }
//
//}
