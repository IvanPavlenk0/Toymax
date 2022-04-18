//
//  SnakeViewController.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 13.04.2022.
//

import UIKit

class SnakeViewController: BaseViewController {
    
    let myView = UIView()
    var timer: Timer!
    var timeRemaining: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.backgroundColor = .systemRed
        myView.frame.size.height = 100
        myView.frame.size.width = 100
        myView.layer.cornerRadius = 50
        myView.center = view.center
        myView.alpha = 0
        view.addSubview(myView)
        
        timeRemaining = 5
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tik), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 3) {
            self.myView.alpha = 1
        }
    }
    
    @objc func tik() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            timer.invalidate()
            let gameOverVC = GameOverViewController(identifireVC: "MatchColorsViewController")
            gameOverVC.modalPresentationStyle = .overFullScreen
            present(gameOverVC, animated: true, completion: nil)
        }
    }
}
