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
        view.distribution = .fillProportionally
        view.spacing = 12.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var institutionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray6
        label.backgroundColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    }
    
    func setupListeners() {
        disposeBag = DisposeBag()
    }
    
}

extension HomeTableViewCell: ValueCell {
    func configureWith(value: HomeTableViewCellViewModelType) {
        viewModel = value
        setupListeners()
    }
}
