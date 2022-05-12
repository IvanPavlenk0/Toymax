//
//  MahjongViewController.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 07.05.2022.
//

import UIKit

class MahjongViewController: BaseViewController {
    
    @IBOutlet weak var mahjongCollectionView: UICollectionView!
    
    private let cards = ["snake", "duck", "alligator", "lion", "panda", "camel", "pig", "dog", "cat", "horse", "sheep", "hen", "fox", "cow", "deer", "giraffe"]
    private let sizeGame = 6 //multiple of 2
    private var imageForGame: [String]!
//    private var timer: Timer!
//    private var timeToRemember = 5
//    var isOn = false
    var picOne: String = ""
    var road: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mahjongCollectionView.register(MahjongCollectionViewCell.nib(), forCellWithReuseIdentifier: MahjongCollectionViewCell.identifier)
        
        setupView()
    }
    
    private func setupView() {
        imageForGame = selectCardsForGame()
        
    }
    
    private func selectCardsForGame() -> [String] {
        let possibleImagesForGame = cards.shuffled()
        let cardsInPlay = sizeGame / 2
        var imageForGame: [String] = []
        for index in 0..<cardsInPlay {
            imageForGame.append(possibleImagesForGame[index])
        }
        imageForGame += imageForGame
        imageForGame.shuffle()
        return imageForGame
    }
    
//    private func hideCards() {
//
//    }
    
//    @objc func tik() {
//        if timeToRemember > 0 {
//            timeToRemember -= 1
//        } else {
//            isOn = true
//           mahjongCollectionView.reloadData()
//            timer.invalidate()
//            timeToRemember = 3
//            isOn = false
//        }
//    }
}

extension MahjongViewController: UICollectionViewDataSource {
    // tels how much cells will be
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageForGame.count
    }
    // what show in cell
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: MahjongCollectionViewCell.identifier, for: indexPath) as? MahjongCollectionViewCell {
            cardCell.configure(with: UIImage(named: imageForGame[indexPath.row])!)
//            timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(tik), userInfo: nil, repeats: true)
//            if isOn {
//                cardCell.showWrappel(isVisible: true)
//            }
            cardCell.showWrappel(isVisible: true)
            cell = cardCell
        }
        return cell
    }
}

extension MahjongViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //change image title on card
        if let cell = collectionView.cellForItem(at: indexPath) as? MahjongCollectionViewCell {
            let pictureName = imageForGame[indexPath.row]
            cell.configure(with: UIImage(named: pictureName)!)
            print(pictureName)
            if picOne.isEmpty {
                picOne = pictureName
                road = indexPath
            } else if picOne == pictureName {
                print("Молодець")
                picOne = ""
            } else {
                print("Спробуй ще")
                cell.showWrappel(isVisible: true)
                //hide first card
                if let previousCell = collectionView.cellForItem(at: road) as? MahjongCollectionViewCell {
                    previousCell.showWrappel(isVisible: true)
                }
                picOne = ""
                road = nil
            }
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? MahjongCollectionViewCell {
//            cell.configure(with: UIImage(named: imageForGame[indexPath.row])!)
//        }
//    }
}
