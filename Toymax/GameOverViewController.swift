//
//  GameOverViewController.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 11.04.2022.
//

import UIKit

class GameOverViewController: BaseViewController {
    
    private let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    private let games = GameLibrary()
    //take identifireVC when create instance GameOverReusableView(identifireVC: String)
    private var identifireVC: String!
    // used 'convenience init' and ' self.init()' bacause GameOverReusableView.xib
    convenience init(identifireVC: String){
        self.init()
        self.identifireVC = identifireVC
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        // save current VC
        let presentingViewController: UIViewController! = self.presentingViewController
        self.dismiss(animated: true) {
            presentingViewController.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        let presentingViewController: UIViewController! = self.presentingViewController
        self.dismiss(animated: true) {
            presentingViewController.view.layoutIfNeeded()
            presentingViewController.loadView()
            presentingViewController.viewDidLoad()
            presentingViewController.viewDidAppear(true)
        }
    }
    
}
