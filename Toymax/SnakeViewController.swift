//
//  SnakeViewController.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 13.04.2022.
//

import UIKit

class SnakeViewController: UIViewController {
    
    let myView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.backgroundColor = .systemRed
        myView.frame.size.height = 100
        myView.frame.size.width = 100
        myView.layer.cornerRadius = 50
        myView.center = view.center
        myView.alpha = 0
        view.addSubview(myView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 5) {
            self.myView.alpha = 1
        }
    }
}
