//
//  SettingsView.swift
//  Pin-UpCasino
//
//  Created by Oleg Yakushin on 3/28/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("speed") private var speed: Int = 1
    var gameManager: GameManager
    var body: some View {
        ZStack{
            BackgroundView()
            VStack(spacing: 20 * sizeScreen()){
                ViewNameView(text: "Settings")
                    .padding()
                RoundedRectangle(cornerRadius: 15 * sizeScreen())
                    .frame(width: 355 * sizeScreen(), height: 51 * sizeScreen())
                    .foregroundColor(Color("GreenOne"))
                    .overlay(
                    Text("Difficulty")
                        .foregroundColor(.white)
                        .font(.custom("Inter-ExtraBold", size: 20 * sizeScreen()))
                    )
                RoundedRectangle(cornerRadius: 15 * sizeScreen())
                    .frame(width: 346 * sizeScreen(), height: 62 * sizeScreen())
                    .foregroundColor(Color("GreenOne"))
                    .overlay(
                        HStack{
                            Text("Easy")
                                .foregroundColor(.white)
                                .font(.custom("Inter-Medium", size: 20 * sizeScreen()))
                            Spacer()
                            Image(speed == 1 ? "checkBoxFilled" : "checkBox")
                                .resizable()
                                .frame(width: 28 * sizeScreen(), height: 28 * sizeScreen())
                        }
                            .padding()
                    )
                    .onTapGesture {
                        speed = 1
                        gameManager.updateGameSpeed(speed: speed)
                    }
                RoundedRectangle(cornerRadius: 15 * sizeScreen())
                    .frame(width: 346 * sizeScreen(), height: 62 * sizeScreen())
                    .foregroundColor(Color("GreenOne"))
                    .overlay(
                        HStack{
                            Text("Medium (x2 points)")
                                .foregroundColor(.white)
                                .font(.custom("Inter-Medium", size: 20 * sizeScreen()))
                            Spacer()
                            Image(speed == 2 ? "checkBoxFilled" : "checkBox")
                                .resizable()
                                .frame(width: 28 * sizeScreen(), height: 28 * sizeScreen())
                        }
                            .padding()
                    )
                    .onTapGesture {
                        speed = 2
                        gameManager.updateGameSpeed(speed: speed)
                    }
                RoundedRectangle(cornerRadius: 15 * sizeScreen())
                    .frame(width: 346 * sizeScreen(), height: 62 * sizeScreen())
                    .foregroundColor(Color("GreenOne"))
                    .overlay(
                        HStack{
                            Text("Hard (x3 points)")
                                .foregroundColor(.white)
                                .font(.custom("Inter-Medium", size: 20 * sizeScreen()))
                            Spacer()
                            Image(speed == 3 ? "checkBoxFilled" : "checkBox")
                                .resizable()
                                .frame(width: 28 * sizeScreen(), height: 28 * sizeScreen())
                        }
                            .padding()
                    )
                    .onTapGesture {
                        speed = 3
                        gameManager.updateGameSpeed(speed: speed)
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
