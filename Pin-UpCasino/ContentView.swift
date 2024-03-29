//
//  ContentView.swift
//  Pin-UpCasino
//
//  Created by Oleg Yakushin on 3/28/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var game = GameManager()
    var body: some View {
        NavigationView{
            ZStack{
                BackgroundView()
                VStack{
                    ViewNameView(text: "Pong UP")
                    Spacer()
                    NavigationLink(destination: GameView(gameManager: game).navigationBarBackButtonHidden()) {
                        GreenButtonView(text: "play")
                    }
                    NavigationLink(destination: StatisticsView(gameManager: game).navigationBarBackButtonHidden()) {
                        GreenButtonView(text: "statistics")
                    }
                    NavigationLink(destination: SettingsView(gameManager: game).navigationBarBackButtonHidden()) {
                        GreenButtonView(text: "settings")
                    }
                    NavigationLink(destination: UpgradesView(gameManager: game).navigationBarBackButtonHidden()) {
                        GreenButtonView(text: "upgrades")
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear{
            game.loadGame()
        }
    }
}

#Preview {
    ContentView()
}
