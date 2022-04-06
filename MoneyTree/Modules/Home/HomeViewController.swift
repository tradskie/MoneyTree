//
//  HomeViewController.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 5/4/22.
//

import UIKit
import RxSwift
import RxDataSources

class HomeViewController<ViewModel, Router>: UIViewController where ViewModel: HomeViewModelType, Router: GeneralRoutable & HomeRoutable {
    // MARK: - Properties -
    // MARK: Internal
    
    var rootView: HomeView {
        return view as! HomeView
    }
    
    // MARK: Private
    
    private(set) lazy var viewModel: ViewModel = ViewModel()
    private var router: Router
    private var disposeBag: DisposeBag!
    
    // MARK: - Initializer and Lifecycle Methods -
    init(viewModel: ViewModel, router: Router) {
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = HomeView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupListeners()
    }
    
    // MARK: - Private API -
    // MARK: Setup Methods
    
    private func setupView() {
        // rootView.tableView.delegate = self
        
        for section in HomeSection.allCases {
            rootView.tableView.registerCellClass(section.cellType)
        }
    }
    
    private func setupListeners() {
        disposeBag = DisposeBag()
    }
}
