//
//  BallView.swift
//  Pin-UpCasino
//
//  Created by Oleg Yakushin on 3/29/24.
//

import SwiftUI

struct BallView: View {
    var name: String
    var description: String
    var unlocked: Bool
    var selected: Bool
    var gameManager: GameManager
    var body: some View {
        RoundedRectangle(cornerRadius: 15 * sizeScreen())
            .frame(width: 291 * sizeScreen(), height: 212 * sizeScreen())
            .foregroundColor(.white.opacity(0.35))
            .overlay(
                VStack{
                    Image(name)
                        .resizable()
                        .frame(width: 75 * sizeScreen(), height: 75 * sizeScreen())
                    Text(name.capitalized)
                        .foregroundColor(.black)
                        .font(.custom("Inter-Bold", size: 20 * sizeScreen()))
                    RoundedRectangle(cornerRadius: 7 * sizeScreen())
                        .frame(width: 221 * sizeScreen(), height: 41 * sizeScreen())
                        .foregroundColor(Color("RedTitle"))
                        .overlay(
                            VStack{
                                if unlocked == true {
                                    HStack{
                                        Image("check")
                                        if selected{
                                            Text("Selected")
                                                .foregroundColor(.white)
                                                .font(.custom("Inter-Medium", size: 20 * sizeScreen()))
                                        }else{
                                            Text("Unlocked")
                                                .foregroundColor(.white)
                                                .font(.custom("Inter-Medium", size: 20 * sizeScreen()))
                                                .onTapGesture {
                                                    gameManager.updateSelectedBall(name: name)
                                                }
                                        }
                                    }
                                }else{
                                    HStack{
                                        Text(description)
                                            .foregroundColor(.white)
                                            .font(.custom("Inter-Medium", size: 15 * sizeScreen()))
                                    }
                                }
                            }
                        )
                }
            )
    }
}

