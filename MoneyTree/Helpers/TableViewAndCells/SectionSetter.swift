//
//  SectionSetter.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 5/4/22.
//

import RxCocoa
import RxDataSources

protocol RelativeOrder {
    var sectionOrder: Int { get }
}

protocol SectionSetter: AnyObject {
    associatedtype Section: SectionModelType & RelativeOrder
    var sectionedItems: BehaviorRelay<[Section]> { get }
    var sectionCache: [Int: Section] { get set}
    
    func setSection(_ section: Section)
}

protocol SectionSetterPlus {
    associatedtype Section: SectionModelType & RelativeOrder
    var dataSource: RxTableViewSectionedReloadDataSource<Section> { get }
}

extension SectionSetter {
    func setSection(_ section: Section) {
        sectionCache[section.sectionOrder] = section
        
        let sortedSection = sectionCache.sorted(by: { $0.0 < $1.0 }).map { $0.1 }
        sectionedItems.accept(sortedSection)
    }
}

protocol TableViewSectionSetter: AnyObject {
    associatedtype Section: SectionModelType & RelativeOrder
    var dataSource: RxTableViewSectionedReloadDataSource<Section> { get }
}

protocol CollectionViewSectionSetter: AnyObject {
    associatedtype Section: SectionModelType & RelativeOrder
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section> { get }
}

enum SectionMismatchError: Error {
    case missingSelf
}
