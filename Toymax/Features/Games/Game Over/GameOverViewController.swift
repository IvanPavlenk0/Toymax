//
//  GameOverViewController.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 11.04.2022.
//

import UIKit

protocol GameManageable {
    func restart()
}

class GameOverViewController: BaseViewController {
    
    private var game: GameManageable! = nil

    // used 'convenience init' and 'self.init()' bacause GameOverReusableView.xib
    convenience init(game: GameManageable){
        self.init()
        self.game = game
        self.modalPresentationStyle = .overFullScreen
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        // save previous VC
        let presentingViewController: UIViewController! = self.presentingViewController
        // deinit current VC
        self.dismiss(animated: true) {
            // deinit previous VC
            presentingViewController.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true) { [weak self] in
            self?.game.restart()
        }
    }
    
}

