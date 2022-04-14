//
//  GameOverReusableView.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 11.04.2022.
//

import UIKit

class GameOverReusableView: UIViewController {
    
    private let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    private let games = GameLibrary()
    //take identifireVC when create instance GameOverReusableView(identifireVC: String)
    private var identifireVC: String!
    // used 'convenience init' and ' self.init()' bacause GameOverReusableView.xib
    convenience init(identifireVC: String){
        self.init()
        self.identifireVC = identifireVC
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        let startVC = storyBoard.instantiateViewController(withIdentifier: "StartScreenCollectionViewController")
        startVC.modalPresentationStyle = .fullScreen
        present(startVC, animated: false, completion: nil)
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        let restartVC = storyBoard.instantiateViewController(withIdentifier: identifireVC)
        restartVC.modalPresentationStyle = .fullScreen
        present(restartVC, animated: false, completion: nil)
    }
}
