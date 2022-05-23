//
//  UITableView+Extension.swift
//  GitSample
//
//  Created by master on 5/23/22.
//

import UIKit

extension UITableView {
    func removeExcessCell() {
        tableFooterView = UIView(frame: .zero)
    }
}
