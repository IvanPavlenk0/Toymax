//
//  GameCollectionViewCell.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 27.04.2022.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var gameImageView: UIImageView!
    
    @IBOutlet weak var nameGameLabel: UILabel!
    
    static let identifier = "GameCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "GameCollectionViewCell",
                     bundle: nil)
    }
    
    public func configure(with nameGame: String) {
        nameGameLabel.text = nameGame
    }
    
    public func configure(with image: UIImage) {
        gameImageView.image = image
    }

}
