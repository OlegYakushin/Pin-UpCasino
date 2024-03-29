//
//  UpgradesView.swift
//  Pin-UpCasino
//
//  Created by Oleg Yakushin on 3/28/24.
//

import SwiftUI

struct UpgradesView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var ballManager = BallManager()
    @ObservedObject var gameManager: GameManager
    var body: some View {
        ZStack{
            BackgroundView()
            VStack{
                ViewNameView(text: "Upgrades")
                    .padding()
                ScrollView(showsIndicators: false){
                    VStack(spacing: 20 * sizeScreen()){
                        ForEach(ballManager.balls.indices, id: \.self) { index in
                            BallView(name: self.ballManager.balls[index].name, description: self.ballManager.balls[index].description, unlocked: self.ballManager.balls[index].unlocked, selected: self.gameManager.game?.selectedBall == self.ballManager.balls[index].name, gameManager: gameManager)
                               }
                    
                    }
                }
                Spacer()
                RoundedRectangle(cornerRadius: 15 * sizeScreen())
                    .frame(width: 349 * sizeScreen(), height: 60 * sizeScreen())
                    .foregroundColor(Color("GreenOne"))
                    .overlay(
                    Text("BACK")
                        .foregroundColor(.white)
                        .font(.custom("Inter-Regular", size: 20 * sizeScreen()))
                    )
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            }
        }
        .onAppear{
            ballManager.loadBalls()
            ballManager.unlockBalls(scoreTotal: gameManager.game!.scoreTotal, score: gameManager.game?.maxScore ?? 0, gamesPlayed: gameManager.game!.gamesPlayed)
            gameManager.updateOpenedBallsCount(balls: ballManager.countUnlockedBalls())
        }
    }
}
