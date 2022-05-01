//
//  SectionHeader.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 27.04.2022.
//

import UIKit

class SectionHeader: UICollectionReusableView {

    @IBOutlet weak var sectionHeaderLabel: UILabel!
    
    static let identifier = "SectionHeader"
    
    static func nib() -> UINib {
        return UINib(nibName: "SectionHeader",
                     bundle: nil)
    }
    
}
