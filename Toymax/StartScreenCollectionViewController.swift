//
//  StartScreenCollectionViewController.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 08.04.2022.
//

import UIKit

class StartScreenCollectionViewController: UICollectionViewController {

    let games: [String] = ["Match colors", "Snake", "Numbers", "Labirynth", "Animals"]
    let images: [String] = ["MatchColors", "Snake", "Numbers", "Labirynth", "Animals"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // tels how much cells will be
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    // what show in cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if let gameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell {
            
            gameCell.configure(with: games[indexPath.row])
            gameCell.configure(with: UIImage(named: images[indexPath.row])!)
            
            cell = gameCell
        }
        return cell
    }
    // when cell was selected
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(games[indexPath.row])
        // create VC using data from storyboard
        let matchColorsViewController = storyboard?.instantiateViewController(withIdentifier: "MatchColorsViewController")
        // make presented VC on full screen
        matchColorsViewController!.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        // show VC
        present(matchColorsViewController!, animated: true, completion: nil)
    }
    
}
