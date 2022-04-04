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
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    
    var subViews: [UIView] = []
    let coloredShape = UIView()
    let colors: [UIColor] = [.systemRed, .systemGreen, .systemGray, .systemMint,
                             .systemOrange, .systemIndigo, .systemPink, .systemYellow]
    var twoColors: [UIColor] = []
    var score: Int = 0
    
    var timeRemaining: Int = 10
    var timer: Timer!
    
    let kScore = "kScore"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
        
        let scoreFromUserDefauts = UserDefaults.standard.integer(forKey: kScore)
        bestScoreLabel.text = scoreFromUserDefauts.description
        
        subViews = [leftView, rightView]
        twoColors = setTwoColors()
        leftView.backgroundColor = twoColors[0]
        rightView.backgroundColor = twoColors[1]
        
        let coloredShape = UIView()
        
        coloredShape.frame.size.height = 100
        coloredShape.frame.size.width = 100
        coloredShape.center = view.center
        coloredShape.backgroundColor = twoColors.randomElement()!
        self.view.addSubview(coloredShape)
        coloredShape.isUserInteractionEnabled = true
        
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.wasDragged(_:)))
        coloredShape.addGestureRecognizer(pan)
        
    }
    private func setTwoColors() -> [UIColor] {
        var anotherTwoColors:[UIColor] = []
        anotherTwoColors.append(colors.randomElement()!)
        while anotherTwoColors.count < 2 {
            anotherTwoColors.append(colors.randomElement()!)
            if anotherTwoColors[0] == anotherTwoColors[1] {
                anotherTwoColors.remove(at: 1)
            }
        }
        return anotherTwoColors
    }
    
    @objc func wasDragged(_ sender: UIPanGestureRecognizer) {
        if timeRemaining == 0 {
            sender.isEnabled = false
        }
        let translation = sender.translation(in: self.view)
        let coloredShape = sender.view!
        coloredShape.center = CGPoint(x: coloredShape.center.x + translation.x,
                                      y: coloredShape.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        if sender.state == .ended {
            
            for view in subViews {
                
                if view.backgroundColor == coloredShape.backgroundColor && view.frame.intersects(coloredShape.frame) {
                    coloredShape.removeFromSuperview()
                    score += 1
                    scoreLabel.text  = "\(score)"
                    
                    twoColors = setTwoColors()
                    leftView.backgroundColor = twoColors[0]
                    rightView.backgroundColor = twoColors[1]
                    coloredShape.center = self.view.center
                    coloredShape.backgroundColor = twoColors.randomElement()!
                    self.view.addSubview(coloredShape)
                
                }
                
            }
        }
    }
    @objc func step() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            timer.invalidate()
            let number = bestScoreLabel.text!
            if  Int(number)! < score {
                UserDefaults.standard.set(score, forKey: kScore)
            }
            let label = UILabel(frame: CGRect(x: self.view.bounds.width / 2 - 100, y: self.view.bounds.height / 2 - 50, width: 200, height: 100))
            label.backgroundColor = .systemIndigo
            label.text = "Your score \(score)"
                           
            label.textAlignment = NSTextAlignment.center
            self.view.addSubview(label)
        }
        timerLabel.text = "\(timeRemaining)"
    }
}

