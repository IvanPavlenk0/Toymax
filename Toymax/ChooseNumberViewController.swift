//
//  ChooseNumberViewController.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 18.04.2022.
//

import UIKit
import AVFoundation

class ChooseNumberViewController: BaseViewController {
    
    @IBOutlet private var buttons: [UIButton]!
    @IBOutlet weak var givenNumberLabel: UILabel!
    
    private let audioNumbers = ["zero", "one", "two", "three", "four", "five",
                               "six", "seven", "eight", "nine", "ten"]
    private let numberOfButtons = 3 ///убрать
    private var currentButtonsTitle: [Int]!
    private var curentVoiceNumber: Int!
    private var priorityList: [Int] = []
    var audioPlayerForNumber: AVAudioPlayer?
    
    //connect ChooseNumberViewController with SceneDelegate(look at code there)
    var delegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        priorityList = Array(0..<audioNumbers.count)
        priorityList.shuffle()
        numberCycle()
    }
    
    private func numberCycle() {
        curentVoiceNumber = priorityList.remove(at: 0)
        playAudio(number: curentVoiceNumber)
        givenNumberLabel.text = audioNumbers[curentVoiceNumber]
        selectElementsForButtons(firstNumber: curentVoiceNumber)
        setButtonsTitle()
    }
    
    private func selectElementsForButtons(firstNumber: Int) {
        var potentialNumber = firstNumber
        currentButtonsTitle = []
        currentButtonsTitle.append(potentialNumber)
        while currentButtonsTitle.count < numberOfButtons {
            if currentButtonsTitle.contains(potentialNumber) {
                potentialNumber = Int.random(in: 0..<audioNumbers.count)
            } else {
                currentButtonsTitle.append(potentialNumber)
            }
        }
        currentButtonsTitle.shuffle()
    }
    
    private func setButtonsTitle() {
        var counter = currentButtonsTitle.count - 1
        buttons.forEach { (button) in
            button.setTitle(currentButtonsTitle[counter].description, for: .normal)
            counter -= 1
        }
    }
    
    @IBAction private func buttonPressed(_ sender: UIButton) {
        if sender.currentTitle == curentVoiceNumber.description {
            print("Красава")
            if priorityList.isEmpty {
                print("Game Over")
                let gameOverVC = GameOverViewController(identifireVC: "ChooseNumberViewController")
                gameOverVC.modalPresentationStyle = .overFullScreen //включить в свой контроллер
                present(gameOverVC, animated: true, completion: nil)
            } else {
                numberCycle()
            }
        } else {
            print("Невiрно набраний номер")
        }
    }
    
    private func playAudio(number: Int) {
        
        if  let path = Bundle.main.path(forResource: audioNumbers[number], ofType: "m4a") {
            audioPlayerForNumber = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayerForNumber?.play()
        } else {
            print("Audiofile is missing")
        }
    }
    
}
