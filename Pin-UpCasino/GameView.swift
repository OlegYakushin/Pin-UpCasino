//
//  GameView.swift
//  Pin-UpCasino
//
//  Created by Oleg Yakushin on 3/28/24.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isPaused = false
    @State private var isEnd = false
    @State private var score = 0
    @ObservedObject var gameManager: GameManager
    var body: some View {
        ZStack{
            BackgroundView()
            VStack{
                if isEnd == false {
                HStack{
                    Spacer()
                    VStack{
                        Image("pause")
                            .onTapGesture {
                                isPaused.toggle()
                                gameManager.updatePause(isPaused: isPaused)
                                                        }
                        Text("\(gameManager.game?.currentScore ?? 0)")
                            .textCase(.uppercase)
                            .foregroundColor(.white)
                            .font(.custom("Inter-ExtraBold", size: 25 * sizeScreen()))
                    }
                }
                .padding()
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        SKViewContainer(scene: GameScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200), gameManager: gameManager, isPaused: isPaused), isPaused: self.$isPaused)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200)
                            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                                isPaused = true
                            }
                    }else{
                        SKViewContainer(scene: GameScene(size: CGSize(width: 390 * sizeScreen(), height: 710 * sizeScreen()), gameManager: gameManager, isPaused: isPaused), isPaused: self.$isPaused)
                            .frame(width: 390 * sizeScreen(), height: 710 * sizeScreen())
                            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                                isPaused = true
                            }
                    }
                }
                                  
            
                  
                    
            }
            if isPaused {
                PausedOverlayView(gameManager: gameManager, isPaused: $isPaused)
                        }
            let endGameResult = gameManager.game?.endGame 
            if endGameResult == true {
                EndOverlayView(gameManager: gameManager, isEnd: $isEnd)
            }
            
        }
        .onDisappear{
            gameManager.resetCurrenrScore()
        }
    }
}

struct PausedOverlayView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var gameManager: GameManager
    @Binding var isPaused: Bool
    var body: some View {
        Color.black.opacity(0.5)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                RoundedRectangle(cornerRadius: 15 * sizeScreen())
                    .frame(width: 283 * sizeScreen(), height: 339 * sizeScreen())
                    .foregroundColor(Color("RedTitle"))
                    .overlay(
                VStack {
                    Text("Pause")
                        .foregroundColor(.white)
                        .font(.custom("Inter-ExtraBold", size: 25 * sizeScreen()))
                    Spacer()
                    RoundedRectangle(cornerRadius: 15 * sizeScreen())
                        .frame(width: 249 * sizeScreen(), height: 50 * sizeScreen())
                        .foregroundColor(Color("GreenOne"))
                        .overlay(
                        Text("Resume")
                            .foregroundColor(.white)
                            .font(.custom("Inter-ExtraBold", size: 20 * sizeScreen()))
                            
                        )
                        .onTapGesture {
                            isPaused = false
                            gameManager.updatePause(isPaused: isPaused)
                                                    }
                        .padding()
                    RoundedRectangle(cornerRadius: 15 * sizeScreen())
                        .frame(width: 249 * sizeScreen(), height: 50 * sizeScreen())
                        .foregroundColor(Color("GreenOne"))
                        .overlay(
                        Text("Exit to menu")
                            .foregroundColor(.white)
                            .font(.custom("Inter-ExtraBold", size: 20 * sizeScreen()))
                            
                        )
                        .padding(.bottom, 70 * sizeScreen())
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                    .padding()
                )
            )
    }
}
struct EndOverlayView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var gameManager: GameManager
    @Binding var isEnd: Bool
    var body: some View {
        Color.black.opacity(0.5)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                RoundedRectangle(cornerRadius: 15 * sizeScreen())
                    .frame(width: 283 * sizeScreen(), height: 339 * sizeScreen())
                    .foregroundColor(Color("RedTitle"))
                    .overlay(
                VStack {
                    Text("End")
                        .foregroundColor(.white)
                        .font(.custom("Inter-ExtraBold", size: 25 * sizeScreen()))
                    Text("Score: \(gameManager.game?.currentScore ?? 0)")
                        .foregroundColor(.white)
                        .font(.custom("Inter-ExtraBold", size: 25 * sizeScreen()))
                        .padding()
                    Spacer()
                    RoundedRectangle(cornerRadius: 15 * sizeScreen())
                        .frame(width: 249 * sizeScreen(), height: 50 * sizeScreen())
                        .foregroundColor(Color("GreenOne"))
                        .overlay(
                        Text("Restart")
                            .foregroundColor(.white)
                            .font(.custom("Inter-ExtraBold", size: 20 * sizeScreen()))
                            
                        )
                        .onTapGesture {
                            isEnd = false
                            gameManager.resetCurrenrScore()
                            }
                        .padding()
                    RoundedRectangle(cornerRadius: 15 * sizeScreen())
                        .frame(width: 249 * sizeScreen(), height: 50 * sizeScreen())
                        .foregroundColor(Color("GreenOne"))
                        .overlay(
                        Text("Exit to menu")
                            .foregroundColor(.white)
                            .font(.custom("Inter-ExtraBold", size: 20 * sizeScreen()))
                            
                        )
                        .padding(.bottom, 70 * sizeScreen())
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                    .padding()
                )
            )
            .onAppear{
                isEnd = true
            }
    }
}

struct SKViewContainer: UIViewRepresentable {
    let scene: SKScene
    @Binding var isPaused: Bool
    
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.backgroundColor = .clear 
        skView.presentScene(scene)
        return skView
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
        if isPaused {
            uiView.scene?.isPaused = true
        } else {
            uiView.scene?.isPaused = false
        }
    }
}
