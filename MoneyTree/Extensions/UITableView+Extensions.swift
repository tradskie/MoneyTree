//
//  UITableView+Extensions.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 6/4/22.
//

import UIKit

extension UITableView {
    func registerCellClass <CellClass: UITableViewCell> (_ cellClass: CellClass.Type) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    func dequeueCell<CellClass: UITableViewCell>(_ cellClass: CellClass.Type, at indexPath: IndexPath) -> CellClass {
        return dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as! CellClass
    }
    
    @discardableResult
    func registerCellNibForClass(_ cellClass: AnyClass) -> UINib {
        let classNameWithoutModule = cellClass
            .description()
            .components(separatedBy: ".")
            .dropFirst()
            .joined(separator: ".")
        
        let nib = UINib(nibName: classNameWithoutModule, bundle: Bundle(for: cellClass))
        register(nib, forCellReuseIdentifier: classNameWithoutModule)
        return nib
    }
    
    func scrollToBottom(animated: Bool = true) {
        let sections = self.numberOfSections
        let rows = self.numberOfRows(inSection: sections - 1)
        if rows > 0 {
            self.scrollToRow(at: IndexPath(row: rows - 1, section: sections - 1), at: .bottom, animated: animated)
        }
    }
    
    func scrollToTop() {
        self.setContentOffset(CGPoint(x: 0, y: -self.adjustedContentInset.top), animated: true)
    }
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}
