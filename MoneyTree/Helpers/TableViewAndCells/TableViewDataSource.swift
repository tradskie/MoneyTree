//
//  TableViewDataSource.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 5/4/22.
//

import RxDataSources

protocol TableViewDataSource: CaseIterable {
    associatedtype Section where Section: SectionModelType, Section == Self
    var cellType: UITableViewCell.Type { get }
    static func generateDataSource() -> RxTableViewSectionedReloadDataSource<Section>
}
