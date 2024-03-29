//
//  BallManager.swift
//  Pin-UpCasino
//
//  Created by Oleg Yakushin on 3/29/24.
//

import Foundation
class BallManager: ObservableObject {
    @Published var balls: [Ball] = []
    
    init() {
        loadBalls()
        if balls.isEmpty {
            initializeBalls()
        }
    }
    
    func unlockBall(at index: Int) {
        guard index >= 0 && index < balls.count else { return }
        balls[index].unlocked = true
        saveBalls()
    }
    
    private func saveBalls() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(balls) {
            UserDefaults.standard.set(encoded, forKey: "balls")
        }
    }
    func countUnlockedBalls() -> Int {
          var count = 0
          for ball in balls {
              if ball.unlocked {
                  count += 1
              }
          }
          return count
      }
    func loadBalls() {
        if let data = UserDefaults.standard.data(forKey: "balls") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Ball].self, from: data) {
                balls = decoded
            }
        }
    }
    func unlockBalls(scoreTotal: Int, score: Int, gamesPlayed: Int) {
            for (index, ball) in balls.enumerated() {
                if !ball.unlocked {
                    switch ball.name {
                    case "soccer guy":
                        if scoreTotal >= 50 {
                            balls[index].unlocked = true
                        }
                    case "playing with fire":
                        if scoreTotal >= 100 {
                            balls[index].unlocked = true
                        }
                    case "sneaky snake":
                        if scoreTotal >= 200 {
                            balls[index].unlocked = true
                        }
                    case "hooper":
                        if gamesPlayed >= 10 {
                            balls[index].unlocked = true
                        }
                    case "magician":
                        if score >= 500 {
                            balls[index].unlocked = true
                        }
                        break
                    default:
                        break
                    }
                }
            }
            saveBalls()
        }
    
    private func initializeBalls() {
        balls = [
            Ball(name: "newbie", description: "", unlocked: true),
            Ball(name: "soccer guy", description: "Score 50 points in total", unlocked: false),
            Ball(name: "playing with fire", description: "Score 100 points in total", unlocked: false),
            Ball(name: "sneaky snake", description: "Score 200 points in total", unlocked: false),
            Ball(name: "hooper", description: "Play 10 games", unlocked: false),
            Ball(name: "magician", description: "Score 500 points in 1 game", unlocked: false),
        ]
        saveBalls()
    }
}

struct Ball: Codable {
    var name: String
    var description: String
    var unlocked: Bool
}
