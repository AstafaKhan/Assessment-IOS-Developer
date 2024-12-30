//
//  ProductListVC.swift
//  Assessment IOS Developer
//
//  Created by Mohammad Astafa Khan on 19/12/2024.
//

import UIKit

class ProductListVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var productListTableView: UITableView!
    @IBOutlet weak var customHeaderView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var categoryCV: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Properties
    private var viewModel = ProductViewModel()
    
    var walletCurrentPage: Int = 0
    var currentCardIndex = 0 {
        didSet {
            self.pageControl?.currentPage = self.currentCardIndex
            DispatchQueue.global(qos: .background).async {
                self.getCategoryList()
            }
        }
    }
    var categoryList: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.pageControl?.numberOfPages = self.categoryList.count
                self.categoryCV?.reloadData()
            }
        }
    }
    var productList: [Product] = [] {
        didSet {
            self.filterList = self.productList
        }
    }
    var filterList: [Product] = [] {
        didSet {
            DispatchQueue.main.async {
                self.productListTableView?.reloadData()
            }
        }
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
    }
}

// MARK: - Helper Functions
extension ProductListVC {
    func configuration() {
        self.categoryList = self.setupData()
        self.registerAllCellClass()
        self.getCategoryList()
        self.observeEvent()
    }
    
    func setupData() -> [String] {
        return ["electronics", "jewelery", "men's clothing", "women's clothing"]
    }
    
    func getCategoryList() {
        if !self.categoryList.isEmpty{
            DispatchQueue.main.async {
                self.productList.removeAll()
                self.filterList.removeAll()
                self.productListTableView.reloadData()
            }
            self.viewModel.fetchProducts(for: self.categoryList[self.currentCardIndex])
        }
    }
    
    func registerAllCellClass() {
        let sharedInstance = DIConfigurator.shared
        sharedInstance.registerCollectionCell(nib: .CategoryCVC, in: self.categoryCV)
        self.categoryCV.collectionViewLayout = CustomCollectionFlowLayout()
        sharedInstance.registerHeaderView(nib: .SearchBarTVH, in: self.productListTableView)
        sharedInstance.registerTableCell(nib: .ProductTVC, in: self.productListTableView)
        self.productListTableView.tableHeaderView = self.customHeaderView
        if #available(iOS 15.0, *) {
            self.productListTableView.sectionHeaderTopPadding = 16
        }
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = false
                    self.activityIndicator.startAnimating()
                }
            case .stopLoading:
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
            case .dataLoaded:
                self.productList = self.viewModel.products
                
            case .error(let error):
                print(error?.localizedDescription ?? "")
            }
        }
    }
}
