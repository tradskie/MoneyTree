//
//  HomeViewModel.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 5/4/22.
//

import Foundation
import RxCocoa
import RxDataSources

protocol HomeViewModelType: SectionSetter, TableViewSectionSetter where Section == HomeSection {
    init()
}

class HomeViewModel: HomeViewModelType {
    var dataSource: RxTableViewSectionedReloadDataSource<Section> = Section.generateDataSource()
    var sectionedItems: BehaviorRelay<[HomeSection]> = BehaviorRelay(value: [])
    var sectionCache = [Int: HomeSection]()
    
    required init() {
        
    }
}
