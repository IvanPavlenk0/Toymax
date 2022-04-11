//
//  ViewController.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 30.03.2022.
//

import UIKit

class MatchColorsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var leftView: UIView!
    @IBOutlet private weak var rightView: UIView!
    @IBOutlet private weak var timerLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var bestScoreLabel: UILabel!
    
    // MARK: - Property
    
    private var subViews: [UIView] = []
    private let coloredShape = UIView()
    private let colors: [UIColor] = [.systemRed, .systemGreen, .systemGray, .systemMint,
                                     .systemOrange, .systemIndigo, .systemPink, .systemYellow]
    private var twoColors: [UIColor] = []
    private var score: Int = 0
    private var timeRemaining: Int = 10
    private var timer: Timer!
    private let kScore = "kScore"
    
    // MARK: - Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tik), userInfo: nil, repeats: true)
        // reserve place at UserDefaults and show score in Label
        let scoreFromUserDefauts = UserDefaults.standard.integer(forKey: kScore)
        bestScoreLabel.text = scoreFromUserDefauts.description
        // set color to Left/Right views
        subViews = [leftView, rightView]
        twoColors = getTwoColors()
        leftView.backgroundColor = twoColors[0]
        rightView.backgroundColor = twoColors[1]
        // configurate coloredShape
        coloredShape.frame.size.height = 100
        coloredShape.frame.size.width = 100
        coloredShape.layer.cornerRadius = 50
        setupView()
//        coloredShape.alpha = 0
        // create and add UIPanGestureRecognizer on coloredShape
        let pan = UIPanGestureRecognizer(target: self, action: #selector(MatchColorsViewController.wasDragged(_:)))
        coloredShape.addGestureRecognizer(pan)
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        coloredShape.fadeOut()
//    }
    
    @objc func wasDragged(_ sender: UIPanGestureRecognizer) {
        if timeRemaining == 0 {
            // stop UIPanGestureRecognizer
            sender.isEnabled = false
        }
        let translation = sender.translation(in: self.view)// what it doing?
        let coloredShape = sender.view!// what it doing?
        coloredShape.center = CGPoint(x: coloredShape.center.x + translation.x,
                                      y: coloredShape.center.y + translation.y)// what it doing?
        sender.setTranslation(CGPoint.zero, in: self.view)// what it doing?
        // when finger let go the coloredShape
        if sender.state == .ended {
            for view in subViews {
                // if colors is equal
                if view.backgroundColor == coloredShape.backgroundColor && view.frame.intersects(coloredShape.frame) {
                    coloredShape.removeFromSuperview()
                    score += 1
                    scoreLabel.text  = "\(score)"
                    // choose new colors and create new item
                    twoColors = getTwoColors()
                    leftView.backgroundColor = twoColors[0]
                    rightView.backgroundColor = twoColors[1]
                    setupView()
                }
            }
        }
    }
    
    @objc func tik() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            // when time is over
            timer.invalidate()
            // get score from UILabel for last game
            let number = bestScoreLabel.text!
            if  Int(number)! < score {
                // set new score at UserDefault if condition 'true'(new score is bigger)
                UserDefaults.standard.set(score, forKey: kScore)
            }
            // create finish label
            let label = UILabel(frame: CGRect(x: self.view.bounds.width / 2 - 100, y: self.view.bounds.height / 2 - 50, width: 200, height: 100))
            label.layer.cornerRadius = 50
            label.layer.masksToBounds = true // what it doing?
            label.backgroundColor = .systemIndigo
            label.text = "Your score \(score)"
            label.textAlignment = NSTextAlignment.center
            self.view.addSubview(label)
        }
        timerLabel.text = "\(timeRemaining)"
    }
    
    @IBAction private func resetButtonPressed(_ sender: UIButton) {
        timer.invalidate()
        self.loadView()
        score = 0
        timeRemaining = 10
        self.viewDidLoad()
    }
    
    private func getTwoColors() -> [UIColor] {
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
    
    private func setupView() {
        coloredShape.center = view.center
        coloredShape.backgroundColor = twoColors.randomElement()!
        view.addSubview(coloredShape)
        coloredShape.isUserInteractionEnabled = true
    }

}

//extension UIView{
//    private func fadeOut() {
//        UIView.animate(withDuration: 1.0, delay: 0.0, animations: {
//            self.alpha = 1.0
//        })
//    }
//}
