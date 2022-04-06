//
//  ValueCellDataSource.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 5/4/22.
//

import UIKit

class ValueCellDataSource: NSObject, UICollectionViewDataSource, UITableViewDataSource {
    
    private var values: [[(value: Any, reusableId: String)]] = []
    
    /**
     Override this method to destructure `cell` and `value` in order to call the `configureWith(value:)` method
     on the cell with the value. This method is called by the internals of `ValueCellDataSource`, it does not
     need to be called directly.
     
     - parameter cell:  A cell that is about to be displayed.
     - parameter value: A value that is associated with the cell.
     */
    open func configureCell(collectionCell cell: UICollectionViewCell, withValue value: Any) {
    }
    
    /**
     Override this method to destructure `cell` and `value` in order to call the `configureWith(value:)` method
     on the cell with the value. This method is called by the internals of `ValueCellDataSource`, it does not
     need to be called directly.
     
     - parameter cell:  A cell that is about to be displayed.
     - parameter value: A value that is associated with the cell.
     */
    open func configureCell(tableCell cell: UITableViewCell, withValue value: Any) {
    }
    
    /**
     Override this to perform any registrations of cell classes and nibs. Call this method from your controller
     before the data source is set on the collection view. If you are using prototype cells you do not need
     to call this.
     
     - parameter collectionView: A collection view that needs to have cells registered.
     */
    open func registerClasses(collectionView: UICollectionView?) {
    }
    
    /**
     Override this to perform any registrations of cell classes and nibs. Call this method from your controller
     before the data source is set on the table view. If you are using prototype cells you do not need
     to call this.
     
     - parameter tableView: A table view that needs to have cells registered.
     */
    open func registerClasses(tableView: UITableView?) {
    }
    
    // MARK: UICollectionViewDataSource methods
    final func numberOfSections(in collectionView: UICollectionView) -> Int {
        return values.count
    }
    
    final func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values[section].count
    }
    
    final func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let (value, reusableId) = values[indexPath.section][indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableId, for: indexPath)
        
        self.configureCell(collectionCell: cell, withValue: value)
        
        return cell
    }
    
    // MARK: UITableViewDataSource methods
    final func numberOfSections(in tableView: UITableView) -> Int {
        return values.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let (value, reusableId) = values[indexPath.section][indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableId, for: indexPath)
        
        self.configureCell(tableCell: cell, withValue: value)
        
        return cell
    }
    
    /**
     Sets an entire section of static cells.
     
     - parameter cellIdentifiers: A list of cell identifiers that represent the rows.
     - parameter section:         The section to replace.
     */
    final func set(cellIdentifiers: [String], inSection section: Int) {
        self.padValuesForSection(section)
        self.values[section] = cellIdentifiers.map { ((), $0) }
    }
    
    /**
     Replaces a section with values.
     
     - parameter values:    An array of values to replace the section with.
     - parameter cellClass: The type of cell associated with the values.
     - parameter section:   The section to replace.
     */
    final func set <
        Cell: ValueCell,
        Value: Any>
        (values: [Value], cellClass: Cell.Type, inSection section: Int, reusableID: String = Cell.defaultReusableId)
        where
        Cell.Value == Value {
            
            self.padValuesForSection(section)
            self.values[section] = values.map { ($0, reusableID) }
    }
    
    /**
     Replaces a row with a value.
     
     - parameter value:     A value to replace the row with.
     - parameter cellClass: The type of cell associated with the value.
     - parameter section:   The section for the row.
     - parameter row:       The row to replace.
     */
    final func set <
        Cell: ValueCell,
        Value: Any>
        (value: Value, cellClass: Cell.Type, inSection section: Int, row: Int)
        where
        Cell.Value == Value {
            
            self.values[section][row] = (value, Cell.defaultReusableId)
    }
    
    private func padValuesForSection(_ section: Int) {
        guard self.values.count <= section else { return }
        
        (self.values.count...section).forEach { _ in
            self.values.append([])
        }
    }
    
}

protocol TableViewSectionType: SectionType where CellType: UITableViewCell {
}

protocol CollectionViewSectionType: SectionType where CellType: UICollectionViewCell {
}

protocol SectionType: RawRepresentable {
    associatedtype CellType: ValueCell
    
    var cellType: CellType.Type { get }
}
