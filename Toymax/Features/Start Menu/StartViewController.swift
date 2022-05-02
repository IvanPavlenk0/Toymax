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
        
        collectionView.register(GameCollectionViewCell.nib(), forCellWithReuseIdentifier: GameCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SectionHeader.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
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
        
        if let gameCell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.identifier, for: indexPath) as? GameCollectionViewCell {
            gameCell.configure(with: games.gameWithName[indexPath.row].gameName)
            gameCell.configure(with: UIImage(named: games.gameWithName[indexPath.row].gameAsset)!)
            cell = gameCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as? SectionHeader {
            sectionHeader.frame = CGRect(x: 0 , y: 0, width: self.view.frame.width, height: 50)
            sectionHeader.sectionHeaderLabel.text = "Select a Game"
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
}

extension StartViewController: UICollectionViewDelegate {
    // when cell was selected
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //select gameVC
        let viewController = games.gameWithName[indexPath.row].viewController()
        viewController.modalPresentationStyle = .fullScreen
        // show VC
        present(viewController, animated: true, completion: nil)
    }
    
}
