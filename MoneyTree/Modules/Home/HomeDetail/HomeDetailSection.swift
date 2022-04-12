//
//  HomeDetailSection.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 11/4/22.
//

import Foundation
import RxDataSources

enum HomeDetailSection: SectionModelType {
    case transactions(items: [HomeTableViewCellViewModel])
    
    var items: [AnyObject] {
        switch self {
        case .transactions(let items):
            return items
        }
        
    }
    
    init(original: HomeDetailSection, items: [AnyObject]) {
        switch original {
        case .transactions:
            self = .transactions(items: items as! [HomeTableViewCellViewModel])
        }
    }
    
}

extension HomeDetailSection: TableViewDataSource {
    typealias Section = HomeDetailSection
    
    static var allCases: [HomeDetailSection] {
        return [
            .transactions(items: [HomeTableViewCellViewModel]())
        ]
    }
    
    static func generateDataSource() -> RxTableViewSectionedReloadDataSource<HomeDetailSection> {
        return RxTableViewSectionedReloadDataSource<HomeDetailSection>(configureCell: { (_, tableView, indexPath, viewModel) -> UITableViewCell in
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
        case .transactions:
            return HomeTableViewCell.self
        }
    }
}

extension HomeDetailSection: RelativeOrder {
    var sectionOrder: Int {
        switch self {
        case .transactions:
            return 0
        }
    }
}
