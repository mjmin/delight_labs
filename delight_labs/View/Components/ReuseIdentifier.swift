//
//  ReuseIdentifier.swift
//  delight_labs
//
//  Created by Minji Kim on 2023/11/13.
//

import UIKit

protocol ReusableViewProtocol {
    static var reuseIdentifier: String { get }
}

extension ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: ReusableViewProtocol {}
extension UITableViewCell: ReusableViewProtocol {}
extension UICollectionReusableView: ReusableViewProtocol {}
extension UITableViewHeaderFooterView: ReusableViewProtocol {}
