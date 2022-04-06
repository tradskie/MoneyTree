//
//  HomeSection.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 5/4/22.
//

import Foundation
import RxDataSources

enum HomeSection: SectionModelType {
case accounts(items: [HomeTableViewCellViewModel])
    
    var items: [AnyObject] {
        switch self {
        case .accounts(let items):
            return items
        }
    }
    
    init(original: HomeSection, items: [AnyObject]) {
        switch original {
        case .accounts:
            self = .accounts(items: items as! [HomeTableViewCellViewModel])
        }
    }
    
}

extension HomeSection: TableViewDataSource {
    typealias Section = HomeSection
    static var allCases: [HomeSection] {
        return [
            .accounts(items: [HomeTableViewCellViewModel]())
        ]
    }
    
    static func generateDataSource() -> RxTableViewSectionedReloadDataSource<HomeSection> {
        return RxTableViewSectionedReloadDataSource<HomeSection>(configureCell: { (_, tableView, indexPath, viewModel) -> UITableViewCell in
            var cell: UITableViewCell!
            if let viewModel = viewModel as? HomeTableViewCellViewModel {
                let newCell = tableView.dequeueCell(HomeTableViewCell.self, at: indexPath)
                newCell.configureWith(value: viewModel)
                cell = newCell
            }
            
            return cell
        })
    }
    
    var cellType: UITableViewCell.Type {
        switch self {
        case .accounts:
            return HomeTableViewCell.self
        }
    }
}

extension HomeSection: RelativeOrder {
    var sectionOrder: Int {
        switch self {
        case .accounts:
            return 0
        }
    }
}
