//
//  CollectionViewCell.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 09.04.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var nameGameLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    public func configure(with nameGame: String) {
        nameGameLabel.text = nameGame
    }
    
    public func configure(with image: UIImage) {
        imageView.image = image
    }
}
