//
//  ChooseNumberViewController.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 18.04.2022.
//

import UIKit
import AVFoundation

class ChooseNumberViewController: BaseViewController, GameManageable {
    
    @IBOutlet private var buttons: [UIButton]!
    @IBOutlet weak var givenNumberLabel: UILabel!
    
    private let audioNumbers = ["zero", "one", "two", "three", "four", "five",
                               "six", "seven", "eight", "nine", "ten"]
    private var currentButtonsTitle: [Int]!
    private var curentVoiceNumber: Int!
    private var priorityList: [Int] = []
    var audioPlayerForNumber: AVAudioPlayer?
    
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
        while currentButtonsTitle.count < buttons.count {
            if currentButtonsTitle.contains(potentialNumber) {
                potentialNumber = Int.random(in: 0..<audioNumbers.count)
            } else {
                currentButtonsTitle.append(potentialNumber)
            }
        }
        currentButtonsTitle.shuffle()
    }
    
    private func setButtonsTitle() {
        for index in 0..<buttons.count {
            buttons[index].setTitle(currentButtonsTitle[index].description, for: .normal)
        }
    }
    
    @IBAction private func buttonPressed(_ sender: UIButton) {
        if sender.currentTitle == curentVoiceNumber.description {
            if priorityList.isEmpty {
                let gameOverVC = GameOverViewController(game: self)
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
    
    func restart() {
      setupView()
    }
    
}
