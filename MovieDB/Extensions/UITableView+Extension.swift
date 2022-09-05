//
//  UITableView+Extension.swift
//  MovieDB
//
//  Created by Roman Bigun on 03.09.2022.
//

import UIKit

extension UITableView {

    func registerNib(_ cellType: UITableViewCell.Type) {
        let cellName = String(describing: cellType.self)
        let nib = UINib(nibName: cellName, bundle: nil)
        register(nib, forCellReuseIdentifier: cellName)
    }
    
    func registerHeaderFooterNibs(for classes: [AnyClass]) {
        classes.map({ String(describing: $0) }).forEach {
            register(UINib(nibName: $0, bundle: nil), forHeaderFooterViewReuseIdentifier: $0)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        let cellName = String(describing: cellType.self)
        let cell = self.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! T
        // swiftlint:disable:previous force_cast
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(for type: T.Type) -> T {
        let identifier = String(describing: type)
        let view = dequeueReusableHeaderFooterView(withIdentifier: identifier) as! T
        // swiftlint:disable:previous force_cast
        return view
    }
    
    func reloadVisibleCells(with animation: UITableView.RowAnimation) {
        let oldValue = UIView.areAnimationsEnabled
        if animation == .none {
            UIView.setAnimationsEnabled(false)
        }
        let indexPaths: [IndexPath] = visibleCells.compactMap { indexPath(for: $0) }
        reloadRows(at: indexPaths, with: animation)
        UIView.setAnimationsEnabled(oldValue)
    }
}
