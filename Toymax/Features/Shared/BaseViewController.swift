//
//  BaseViewController.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 14.04.2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    private func printState(isInit: Bool){
        print((isInit ? "I" : "Dei") + "nit of \(type(of: self))")
    }

    override init(nibName: String?, bundle: Bundle?){
        super.init(nibName: nibName, bundle: bundle)
        printState(isInit: true)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        printState(isInit: true)
    }
    
    deinit{
        printState(isInit: false)
    }
    
}

