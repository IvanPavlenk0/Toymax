//
//  UICollectionViewCell+Identifier.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 01.05.2022.
//

import UIKit

extension UICollectionReusableView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier,
                     bundle: nil)
    }
    
}
