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
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
