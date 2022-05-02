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
        var viewController: () -> (UIViewController)
    }
    
    let gameWithName: [GameInfo] = [
        (GameInfo(gameName: "Match colors", gameAsset: "MatchColors", viewController: { MatchColorsViewController() })),
        (GameInfo(gameName: "Snake", gameAsset: "Snake", viewController: { SnakeViewController() })),
        (GameInfo(gameName: "Numbers", gameAsset: "Numbers", viewController: { ChooseNumberViewController() }))]
    
}
