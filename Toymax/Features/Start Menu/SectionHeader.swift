//
//  SectionHeader.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 27.04.2022.
//

import UIKit

class SectionHeader: UICollectionReusableView {

    @IBOutlet weak var sectionHeaderLabel: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier,
                     bundle: nil)
    }
    
}
