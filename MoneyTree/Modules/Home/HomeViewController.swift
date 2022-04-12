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
        
        viewModel.sectionedItems
            .bind(to: rootView.tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
        
        viewModel.accounts
            .subscribe(onNext: { [weak self] (value) in
                guard let strongSelf = self else { return }
                strongSelf.viewModel.setSection(.accounts(items: value))
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
        
        rootView.tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] (indexPath) in
                guard let strongSelf = self else { return }
                switch indexPath.section {
                case HomeSection.accounts(items: [HomeTableViewCellViewModel]()).sectionOrder:
                    guard let cell = strongSelf.rootView.tableView.cellForRow(at: indexPath) as? HomeTableViewCell,
                          let id = cell.viewModel.id.value,
                          let name = cell.viewModel.name.value,
                          let currency = cell.viewModel.currency.value
                    else { return }
                    strongSelf.router.navigateToDetail(id: id, name: name, currency: currency)
                default: break
                }
            })
            .disposed(by: disposeBag)
    }
}
