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
        var identifierVC: String
    }
    
    var gameWithName = [GameInfo]()
    
    init() {
        gameWithName.append(GameInfo(gameName: "Match colors", gameAsset: "MatchColors", identifierVC: "MatchColorsViewController"))
        gameWithName.append(GameInfo(gameName: "Snake", gameAsset: "Snake", identifierVC: "SnakeViewController"))
    }
    
}
