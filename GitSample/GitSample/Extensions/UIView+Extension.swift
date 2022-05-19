//
//  UIView+Extension.swift
//  GitSample
//
//  Created by master on 5/18/22.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
