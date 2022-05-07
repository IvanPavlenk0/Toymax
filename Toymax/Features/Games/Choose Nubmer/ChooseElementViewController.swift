//
//  ChooseNumberViewController.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 18.04.2022.
//

import UIKit
import AVFoundation

protocol ModelUsable {
    var gameData: [GameData] {get}
}

struct GameData {
    var dataToGame: String
    var dataToDisplay: String
    var dataToAudio: String
}

class ChooseElementViewController: BaseViewController, GameManageable {
    
    @IBOutlet private var buttons: [UIButton]!
    @IBOutlet weak var elementLabel: UILabel!
    
    private let stadyModel = NumberModel()
    private var currentButtonsTitle: [String]!
    private var curentElement: GameData!
    private var priorityList: [GameData] = []
//    var audioPlayerForNumber: AVAudioPlayer?
    let synth = AVSpeechSynthesizer()
    let speechDelay = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        priorityList = stadyModel.gameData
        priorityList.shuffle()
        elementCycle()
    }
    
    private func elementCycle() {
        curentElement = priorityList.remove(at: 0)
//        playAudio(number: curentVoiceElement)
        speakInfo(string: curentElement.dataToAudio)
        elementLabel.text = curentElement.dataToDisplay
        selectElementsForButtons(firstElement: curentElement.dataToGame)
        setButtonsTitle()
    }
    
    private func selectElementsForButtons(firstElement: String) {
        var potentialElement = firstElement
        currentButtonsTitle = []
        currentButtonsTitle.append(potentialElement)
        while currentButtonsTitle.count < buttons.count {
            if currentButtonsTitle.contains(potentialElement) {
                let position = Int.random(in: 0..<stadyModel.gameData.count)
                potentialElement = stadyModel.gameData[position].dataToGame
            } else {
                currentButtonsTitle.append(potentialElement)
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
        if sender.currentTitle == curentElement.dataToGame {
            if priorityList.isEmpty {
                let gameOverVC = GameOverViewController(game: self)
                present(gameOverVC, animated: true, completion: nil)
            } else {
                elementCycle()
            }
        } else {
            print("Невiрно набраний номер")
        }
    }
    
//    private func playAudio(number: Int) {
//        if  let path = Bundle.main.path(forResource: numbers.audioNumbers[number], ofType: "m4a") {
//            audioPlayerForNumber = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
//            audioPlayerForNumber?.play()
//        } else {
//            print("Audiofile is missing")
//        }
//    }
    
    private func speakInfo(string: String) {
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        // delay to audio info
        DispatchQueue.main.asyncAfter(deadline: .now() + speechDelay) {
            self.synth.speak(utterance)
            }
    }
    
    func restart() {
      setupView()
    }
    
}
