//
//  ViewController.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 30.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    var subViews: [UIView] = []
    let coloredShape = UIView()
    let colors: [UIColor] = [.systemRed, .systemGreen]
    var counter = 5
    override func viewDidLoad() {
        super.viewDidLoad()
        subViews = [leftView, rightView]
        
        leftView.backgroundColor = .systemRed
        rightView.backgroundColor = .systemGreen
        
        let coloredShape = UIView()
        
        coloredShape.frame.size.height = 100
        coloredShape.frame.size.width = 100
        coloredShape.center = view.center
        coloredShape.backgroundColor = colors.randomElement()!
        self.view.addSubview(coloredShape)
        coloredShape.isUserInteractionEnabled = true
        
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.wasDragged(_:)))
        coloredShape.addGestureRecognizer(pan)
        
    }
    
    @objc func wasDragged(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: self.view)
        let coloredShape = sender.view!
        coloredShape.center = CGPoint(x: coloredShape.center.x + translation.x,
                                      y: coloredShape.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        if sender.state == .ended {
            
            for view in subViews {
                
                if view.backgroundColor == coloredShape.backgroundColor && view.frame.intersects(coloredShape.frame) {
                    coloredShape.removeFromSuperview()
                    counter -= 1
                    print(counter)
                    
                    if counter > 0 {
                        
                        coloredShape.center = self.view.center
                        coloredShape.backgroundColor = colors.randomElement()!
                        self.view.addSubview(coloredShape)
                        
                    } else {
                        
                        let label = UILabel(frame: CGRect(x: self.view.bounds.width / 2 - 100, y: self.view.bounds.height / 2 - 50, width: 200, height: 100))
                        label.backgroundColor = .systemIndigo
                        label.text = "Well done!"
                        label.textAlignment = NSTextAlignment.center
                        self.view.addSubview(label)
                        return
                        
                    }
                }
                
            }
        }
    }
}
