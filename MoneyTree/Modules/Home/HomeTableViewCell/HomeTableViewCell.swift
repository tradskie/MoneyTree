//
//  HomeTableViewCell.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 6/4/22.
//

import Foundation
import RxSwift
import RxCocoa

class HomeTableViewCell: UITableViewCell {
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.axis = .vertical
        view.spacing = 12.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var headerContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private lazy var contentContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: HomeTableViewCellViewModelType = HomeTableViewCellViewModel()
    var disposeBag: DisposeBag!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupListeners()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = nil
    }
    
    func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(stackView)
        headerContainerView.addSubview(titleLabel)
        stackView.addArrangedSubview(headerContainerView)
        contentContainerView.addSubview(nameLabel)
        contentContainerView.addSubview(amountLabel)
        stackView.addArrangedSubview(contentContainerView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: headerContainerView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: -8),
            
            nameLabel.topAnchor.constraint(equalTo: contentContainerView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor, constant: -8),
            
            amountLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            amountLabel.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant:  -8)
        ])
        
    }
    
    func setupListeners() {
        disposeBag = DisposeBag()
        viewModel.title
            .asDriver()
            .drive(onNext: { [weak self] title in
                guard let strongSelf = self else { return }
                
                strongSelf.titleLabel.text = title
                strongSelf.headerContainerView.isHidden = title == nil
            })
            .disposed(by: disposeBag)
        
        viewModel.name
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let strongSelf = self, let name = $0 else { return }
                
                strongSelf.nameLabel.text = name
                
            })
            .disposed(by: disposeBag)
        
        viewModel.currency
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let strongSelf = self, let currency = $0, let balance = strongSelf.viewModel.currentBalance.value else { return }
                
                strongSelf.amountLabel.text = PriceFormatter.format(amount: balance, currencyCode: currency)
                
            })
            .disposed(by: disposeBag)
        
        viewModel.currentBalance
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let strongSelf = self, let balance = $0, let currency = strongSelf.viewModel.currency.value else { return }
                
                strongSelf.amountLabel.text = PriceFormatter.format(amount: balance, currencyCode: currency)
                
            })
            .disposed(by: disposeBag)
    }
    
}

extension HomeTableViewCell: ValueCell {
    func configureWith(value: HomeTableViewCellViewModelType) {
        viewModel = value
        setupListeners()
    }
}
