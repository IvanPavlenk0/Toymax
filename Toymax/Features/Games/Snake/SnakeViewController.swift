//
//  SnakeViewController.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 13.04.2022.
//

import UIKit

class SnakeViewController: BaseViewController, GameManageable {
    
    let myView = UIView()
    var timer: Timer!
    var timeRemaining: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        myView.backgroundColor = .systemRed
        myView.frame.size.height = 100
        myView.frame.size.width = 100
        myView.layer.cornerRadius = 50
        myView.center = view.center
        myView.alpha = 0
        view.addSubview(myView)
        // adjust timer
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
            let gameOverVC = GameOverViewController(game: self)
            present(gameOverVC, animated: true, completion: nil)
        }
    }
    
    func restart() {
        setupView()
        viewDidAppear(true)
    }
    
}
