//
//  GameLibrary.swift
//  Toymax
//
//  Created by Ivan Pavlenko on 13.04.2022.
//

import UIKit

class GameLibrary {
    
    struct GameInfo {
        var gameName: String
        var gameAsset: String
        var viewController: UIViewController
    }
    
    var gameWithName = [GameInfo]()
    
    init() {
        gameWithName.append(GameInfo(gameName: "Match colors", gameAsset: "MatchColors", viewController: MatchColorsViewController()))
        gameWithName.append(GameInfo(gameName: "Snake", gameAsset: "Snake", viewController: SnakeViewController()))
        gameWithName.append(GameInfo(gameName: "Numbers", gameAsset: "Numbers", viewController: ChooseNumberViewController()))
    }
    
}
