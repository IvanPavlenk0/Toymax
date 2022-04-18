//
//  StartViewController.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 08.04.2022.
//

import UIKit

class StartViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let games = GameLibrary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: "SectionHeader", withReuseIdentifier: "SectionHeader")
    }
    
}

extension StartViewController: UICollectionViewDataSource {
    // tels how much cells will be
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.gameWithName.count
    }
    // what show in cell
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if let gameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell {
            
            gameCell.configure(with: games.gameWithName[indexPath.row].gameName)
            gameCell.configure(with: UIImage(named: games.gameWithName[indexPath.row].gameAsset)!)
            cell = gameCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
            sectionHeader.sectionHeaderLabel.text = "Huy"
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
}

extension StartViewController: UICollectionViewDelegate {
    // when cell was selected
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // create VC using data from storyboard
        let matchColorsViewController = storyboard?.instantiateViewController(withIdentifier: games.gameWithName[indexPath.row].identifierVC)
        // make presented VC on full screen
        matchColorsViewController!.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        // show VC
        present(matchColorsViewController!, animated: true, completion: nil)
    }
    
}
