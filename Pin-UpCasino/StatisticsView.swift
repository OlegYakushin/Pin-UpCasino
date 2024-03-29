//
//  StatisticsView.swift
//  Pin-UpCasino
//
//  Created by Oleg Yakushin on 3/28/24.
//

import SwiftUI

struct StatisticsView: View {
    @Environment(\.presentationMode) var presentationMode
    var gameManager: GameManager
    var body: some View {
        ZStack{
            BackgroundView()
            VStack{
                ViewNameView(text: "Statistics")
                    .padding()
                ScrollView(showsIndicators: false){
                    VStack(spacing: 20 * sizeScreen()){
                        EachStatView(text: "Highest score in one game", amount: gameManager.game!.maxScore, amountText: "points")
                        EachStatView(text: "Longest game time", amount: gameManager.game!.longestTime, amountText: "s")
                        EachStatView(text: "Balls owned", amount: gameManager.game!.openedBallsCount, amountText: "balls")
                        EachStatView(text: "Days in the game", amount: gameManager.game!.daysInGame, amountText: "days")
                        EachStatView(text: "Games played", amount: gameManager.game!.gamesPlayed, amountText: "games")
                        EachStatView(text: "Score total", amount: gameManager.game!.scoreTotal, amountText: "points")
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
    }
}

