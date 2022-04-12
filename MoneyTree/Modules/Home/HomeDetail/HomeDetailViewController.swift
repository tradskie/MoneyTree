//
//  HomeDetailViewController.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 11/4/22.
//

import UIKit
import RxSwift
import RxDataSources

class HomeDetailViewController<ViewModel, Router>: UIViewController where ViewModel: HomeDetailViewModelType, Router: GeneralRoutable {
    // MARK: - Properties -
    // MARK: Internal
    
    var rootView: HomeDetailView {
        return view as! HomeDetailView
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
        view = HomeDetailView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupListeners()
    }
    
    // MARK: - Private API -
    // MARK: Setup Methods
    
    private func setupView() {
         for section in HomeDetailSection.allCases {
            rootView.tableView.registerCellClass(section.cellType)
         }
    }
    
    private func setupListeners() {
        disposeBag = DisposeBag()
        
        viewModel.sectionedItems
            .bind(to: rootView.tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
        
        viewModel.transactions
            .subscribe(onNext: { [weak self] (value) in
                guard let strongSelf = self else { return }
                strongSelf.viewModel.setSection(.transactions(items: value))
            })
            .disposed(by: disposeBag)
        
        viewModel.notifyError
            .subscribe(onNext: { [weak self] (value) in
                guard let strongSelf = self, let value = value else { return }
                DispatchQueue.main.async {
                    strongSelf.router.handleError(error: value)
                }
            })
            .disposed(by: disposeBag)
    }
    
}
