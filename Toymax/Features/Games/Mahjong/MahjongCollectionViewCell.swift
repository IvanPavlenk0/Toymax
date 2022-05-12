//
//  MahjongCollectionViewCell.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 07.05.2022.
//

import UIKit

class MahjongCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardImageView: UIImageView!
    
    var timer: Timer!
    var delay = 3
    
    public func configure (with name: UIImage) {
        cardImageView.image = name
    }
    
    public func showWrappel(isVisible: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tik), userInfo: nil, repeats: true)
    }
    
    @objc func tik() {
        if delay > 0 {
            delay -= 1
        } else {
            cardImageView.image = UIImage(named: "wrappel")
            timer.invalidate()
        }
    }

}
