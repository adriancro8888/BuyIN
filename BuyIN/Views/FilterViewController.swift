import UIKit

class FilterViewController : UIViewController {
    
    var productsView : ProductsViewController!
    
    private var backView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.alpha = 0.75
        
        return view
        
    }()
    private lazy var blurredVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterial)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        view.layer.shadowOpacity = 1
        view .layer.shadowRadius = 5
        return view
    }()
    
    
    private let applyButton: RoundedButton = {
        let button = RoundedButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.setTitle("Apply", for: .normal)
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private let clearButton: RoundedButton = {
        let button = RoundedButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .systemGray
        button.setTitle("Clear", for: .normal)
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private func getFilterButton(_ title : String) -> RoundedButton{
        let button = RoundedButton(type: .system)
        button.tintColor = .label
        button.backgroundColor = .systemGray4
        button.setTitle(title, for: .normal)
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    private var brandsButton: RoundedButton!// = {
    //        return getFilterButton("Brand : ")
    //    }()
    private var categoryButton: RoundedButton!// = {
    //        return getFilterButton("Category : ")
    //    }()
    private var tagButton: RoundedButton!// = {
    //        return getFilterButton("Tag : ")
    //    }()
    private var typeButton: RoundedButton!// = {
    //        return getFilterButton("Type : ")
    //    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brandsButton = getFilterButton("Brand")
        categoryButton = getFilterButton("Category")
        tagButton = getFilterButton("Tag")
        typeButton = getFilterButton("Type")
        
        
        let tapRecognizer = UITapGestureRecognizer()
        backView.addGestureRecognizer(tapRecognizer)
        
        view.addSubview(backView)
        view.addSubview(blurredVisualEffect)
        blurredVisualEffect.contentView.addSubview(applyButton)
        blurredVisualEffect.contentView.addSubview(clearButton)
        blurredVisualEffect.contentView.addSubview(brandsButton)
        blurredVisualEffect.contentView.addSubview(categoryButton)
        blurredVisualEffect.contentView.addSubview(tagButton)
        blurredVisualEffect.contentView.addSubview(typeButton)
        
        
        
        self.view.isHidden = true
        applyButton.addTarget(self, action: #selector(applyButtonClicked), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearButtonClicked), for: .touchUpInside)
        
        brandsButton.addTarget(self, action: #selector(openBrandsFilter), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(openCategoryFilter), for: .touchUpInside)
        tagButton.addTarget(self, action: #selector(openTagsFilter), for: .touchUpInside)
        typeButton.addTarget(self, action: #selector(openTypesFilter), for: .touchUpInside)
        
        
        tapRecognizer.addTarget(self, action: #selector(applyButtonClicked))
        
        setConstrains()
    }
    @objc private func openBrandsFilter() {
        self.openFilter(button: self.brandsButton, dataSource: Client.shared.Brands, titlte: "Brands")
    }
    @objc private func openCategoryFilter() {
        self.openFilter(button: self.categoryButton, dataSource: Client.shared.Categories, titlte: "Category")
    }
    @objc private func openTagsFilter() {
        self.openFilter(button: self.tagButton, dataSource: Client.shared.Tags, titlte: "Tag")
    }
    @objc private func openTypesFilter() {
        self.openFilter(button: self.typeButton, dataSource: Client.shared.Types, titlte: "Type")
    }
    func openFilter(button : UIButton , dataSource :[String], titlte:String){
        
        let regularFont = UIFont.systemFont(ofSize: 16)
        let boldFont = UIFont.boldSystemFont(ofSize: 16)
        let blueColor:UIColor = .systemBlue
        let blueAppearance = YBTextPickerAppearanceManager.init(
            pickerTitle         : titlte,
            titleFont           : boldFont,
            titleTextColor      : .black,
            titleBackground     : blueColor,
            searchBarFont       : regularFont,
            searchBarPlaceholder: "Search \(titlte)",
            closeButtonTitle    : "Cancel",
            closeButtonColor    : .darkGray,
            closeButtonFont     : regularFont,
            doneButtonTitle     : "Done",
            doneButtonColor     : blueColor,
            doneButtonFont      : boldFont,
            checkMarkPosition   : .Right,
            itemCheckedImage    : UIImage(named:"blue_ic_checked"),
            itemUncheckedImage  : UIImage(),
            itemColor           : .black,
            itemFont            : regularFont
        )
        
        let picker = YBTextPicker.init(with: dataSource, appearance: blueAppearance, onCompletion: { (selectedIndexes, selectedValues) in
            if let selectedValue = selectedValues.first{
                button.setTitle(selectedValue, for: .normal)
                button.tintColor = .systemBlue
                button.tag = 1 ;
            }else{
                button.setTitle(titlte, for: .normal)
                button.tintColor = .label
                button.tag = 0 ;
            }
        }, onCancel: {
            
        })
        
        picker.show(withAnimation: .Fade)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backView.frame = view.bounds
    }
    @objc private func applyButtonClicked() {
        self.view.isHidden = true
        
        
        if self.brandsButton.tag == 1{
            self.productsView.brandFilter = self.brandsButton.title(for: .normal)
        }else{
            self.productsView.brandFilter = nil
        }
        
        
        if self.categoryButton.tag == 1{
            self.productsView.categoryFilter = self.categoryButton.title(for: .normal)
        }else{
            self.productsView.categoryFilter = nil
        }
        
        
        if self.typeButton.tag == 1{
            self.productsView.typeFilter = self.typeButton.title(for: .normal)
        }else{
            self.productsView.typeFilter = nil
        }
        if self.tagButton.tag == 1{
            self.productsView.tagFilter = self.tagButton.title(for: .normal)
        }else{
            self.productsView.tagFilter = nil
        }
        self.productsView.applyFiltring()
    }
    @objc private func clearButtonClicked() {
        self.view.isHidden = true
        
        
        brandsButton.setTitle("Brand", for: .normal)
        brandsButton.tintColor = .label
        brandsButton.tag = 0 ;
        
        categoryButton.setTitle("Category", for: .normal)
        categoryButton.tintColor = .label
        categoryButton.tag = 0 ;
        
        typeButton.setTitle("Type", for: .normal)
        typeButton.tintColor = .label
        typeButton.tag = 0 ;
        
        tagButton.setTitle("Tag", for: .normal)
        tagButton.tintColor = .label
        tagButton.tag = 0 ;
        
        self.productsView.brandFilter = nil
        self.productsView.categoryFilter = nil
        self.productsView.typeFilter = nil
        self.productsView.tagFilter = nil
        
        
        self.productsView.applyFiltring()
    }
    
    func showViewAnimated(){
        self.view.isHidden = false
        
    }
    
    func setConstrains() {
        
        let blurredVisualEffectConstraints = [
            blurredVisualEffect.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            blurredVisualEffect.heightAnchor.constraint(equalToConstant: 450),
            blurredVisualEffect.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            //    blurredVisualEffect.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
            blurredVisualEffect.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        
        
        
        let applyButtonConstraints = [
            applyButton.bottomAnchor.constraint(equalTo: blurredVisualEffect.bottomAnchor, constant: -25),
            applyButton.heightAnchor.constraint(equalToConstant: 55),
            applyButton.widthAnchor.constraint(equalTo: blurredVisualEffect.widthAnchor,  multiplier:0.44),
            applyButton.trailingAnchor.constraint(equalTo: blurredVisualEffect.trailingAnchor, constant: -25)
        ]
        
        
        let clearButtonConstraints = [
            clearButton.bottomAnchor.constraint(equalTo: blurredVisualEffect.bottomAnchor, constant: -25),
            clearButton.heightAnchor.constraint(equalToConstant: 55),
            clearButton.widthAnchor.constraint(equalTo: blurredVisualEffect.widthAnchor,  multiplier:0.4),
            clearButton.leadingAnchor.constraint(equalTo: blurredVisualEffect.leadingAnchor, constant: 25)
        ]
        
        
        let brandButtonConstraints = [
            brandsButton.topAnchor.constraint(equalTo: blurredVisualEffect.topAnchor, constant: 25),
            brandsButton.heightAnchor.constraint(equalToConstant: 55),
            brandsButton.leadingAnchor.constraint(equalTo: blurredVisualEffect.leadingAnchor, constant: 25),
            brandsButton.trailingAnchor.constraint(equalTo: blurredVisualEffect.trailingAnchor, constant: -25)
            
        ]
        
        
        let categoryButtonConstrains = [
            categoryButton.topAnchor.constraint(equalTo: brandsButton.bottomAnchor, constant: 15),
            categoryButton.heightAnchor.constraint(equalTo : brandsButton.heightAnchor , multiplier:1),
            categoryButton.leadingAnchor.constraint(equalTo: brandsButton.leadingAnchor, constant: 0),
            categoryButton.trailingAnchor.constraint(equalTo: brandsButton.trailingAnchor, constant: 0)
            
        ]
        
        let tagButtonConstrains = [
            tagButton.topAnchor.constraint(equalTo: categoryButton.bottomAnchor, constant: 15),
            tagButton.heightAnchor.constraint(equalTo : brandsButton.heightAnchor , multiplier:1),
            tagButton.leadingAnchor.constraint(equalTo: brandsButton.leadingAnchor, constant: 0),
            tagButton.trailingAnchor.constraint(equalTo: brandsButton.trailingAnchor, constant: 0)
            
        ]
        let typeButtonConstrains = [
            typeButton.topAnchor.constraint(equalTo: tagButton.bottomAnchor, constant: 15),
            typeButton.heightAnchor.constraint(equalTo : brandsButton.heightAnchor , multiplier:1),
            typeButton.leadingAnchor.constraint(equalTo: brandsButton.leadingAnchor, constant: 0),
            typeButton.trailingAnchor.constraint(equalTo: brandsButton.trailingAnchor, constant: 0)
            
        ]
        NSLayoutConstraint.activate(blurredVisualEffectConstraints)
        NSLayoutConstraint.activate(applyButtonConstraints)
        NSLayoutConstraint.activate(clearButtonConstraints)
        NSLayoutConstraint.activate(brandButtonConstraints)
        NSLayoutConstraint.activate(categoryButtonConstrains)
        NSLayoutConstraint.activate(tagButtonConstrains)
        NSLayoutConstraint.activate(typeButtonConstrains)
    }
    
}
