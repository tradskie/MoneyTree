//
//  HomeView.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 6/4/22.
//

import UIKit

class HomeView: UIView {
    // MARK: - Properties -
    // MARK: Internal
    
    lazy var tableView: UITableView = {
        let newTableView = UITableView(frame: .zero, style: .plain)
        newTableView.translatesAutoresizingMaskIntoConstraints = false
        newTableView.backgroundView = nil
        newTableView.estimatedRowHeight = 150.0
        newTableView.rowHeight = UITableView.automaticDimension
        newTableView.separatorStyle = .none
        newTableView.showsVerticalScrollIndicator = false
        newTableView.backgroundColor = .clear
        return newTableView
    }()
    
    private lazy var headerContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textColor = .label
        label.text = "Digital Money"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32)
        label.textColor = .label
        label.minimumScaleFactor = 0.5
        label.text = "JPY 1,813,607" // suppose to add currency conversion
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    // MARK: - Initializer and Lifecycle Methods -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemOrange
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(headerContainerView)
        headerContainerView.addSubview(titleLabel)
        headerContainerView.addSubview(amountLabel)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            headerContainerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            
            titleLabel.topAnchor.constraint(equalTo: headerContainerView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: -8),
            
            amountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            amountLabel.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor, constant: 8),
            amountLabel.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: -8),
            amountLabel.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: -8),
            
            tableView.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
