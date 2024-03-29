//
//  GameManager.swift
//  Pin-UpCasino
//
//  Created by Oleg Yakushin on 3/28/24.
//

import Foundation

class GameManager: ObservableObject {
    @Published var game: Game?

    init() {
           loadGame()
        resetCurrenrScore()
        calculateDaysInGame()
        if game == nil {
                   initializeGame()
               }
       }

    private func calculateDaysInGame() {
        guard let game = game else { return }
        
      
        guard game.daysInGame == 0 else { return }
        
        let firstLaunchDate = UserDefaults.standard.object(forKey: "firstLaunchDate") as? Date ?? Date()
        let currentDate = Date()
        let calendar = Calendar.current
        let days = calendar.dateComponents([.day], from: firstLaunchDate, to: currentDate).day ?? 0
        let adjustedDays = max(1, days)
        updateDaysInGame(days: adjustedDays)
    }
    
    func updateDaysInGame(days: Int) {
           guard var game = game else { return }
           game.daysInGame = days
           self.game = game
           
           if days == 0 {
               UserDefaults.standard.set(Date(), forKey: "firstLaunchDate")
           }
           
           saveGame()
       }
    private func saveGame() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(game) {
            UserDefaults.standard.set(encoded, forKey: "game")
        }
    }
    
    func loadGame() {
        if let data = UserDefaults.standard.data(forKey: "game") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(Game.self, from: data) {
                game = decoded
            }
        }
    }
    private func initializeGame() {
        game = Game(maxScore: 0, longestTime: 0, openedBallsCount: 1, daysInGame: 0, gamesPlayed: 0, selectedBall: "newbie", gameSpeed: 1, currentScore: 0, paused: false, endGame: false, scoreTotal: 0)
        saveGame()
    }
    func updateSelectedBall(name: String) {
            guard var game = game else { return }
            game.selectedBall = name
            self.game = game
            saveGame()
        }
    func updateGameSpeed(speed: Int) {
            guard var game = game else { return }
            game.gameSpeed = speed
            self.game = game
            saveGame()
        }
    func updateLongestTime(time: Int) {
            guard var game = game else { return }
        game.longestTime = time
            self.game = game
            saveGame()
        }
    func updateScore(score: Int) {
            guard var game = game else { return }
        game.maxScore = score
            self.game = game
            saveGame()
        }
    func updateCurrenrScore(score: Int) {
            guard var game = game else { return }
        game.currentScore = score
            self.game = game
            saveGame()
        }
    func resetCurrenrScore() {
            guard var game = game else { return }
        game.currentScore = 0
        game.endGame = false
            self.game = game
            saveGame()
        }
    func updateGamesPlayed() {
            guard var game = game else { return }
        game.gamesPlayed += 1
            self.game = game
            saveGame()
        }
    func updatePause(isPaused: Bool) {
            guard var game = game else { return }
        game.paused = isPaused
            self.game = game
            saveGame()
        }
    func endGame(isEnd: Bool) {
            guard var game = game else { return }
        game.endGame = isEnd
            self.game = game
            saveGame()
        }
    func addScore(score: Int) {
            guard var game = game else { return }
        game.scoreTotal += score
            self.game = game
            saveGame()
        }
    func updateOpenedBallsCount(balls: Int) {
            guard var game = game else { return }
        game.openedBallsCount = balls
            self.game = game
            saveGame()
        }
}

struct Game: Codable {
    var maxScore: Int
    var longestTime: Int
    var openedBallsCount: Int
    var daysInGame: Int
    var gamesPlayed: Int
    var selectedBall: String
    var gameSpeed: Int
    var currentScore: Int
    var paused: Bool
    var endGame: Bool
    var scoreTotal: Int
}
