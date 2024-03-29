//
//  EachStatView.swift
//  Pin-UpCasino
//
//  Created by Oleg Yakushin on 3/28/24.
//

import SwiftUI

struct EachStatView: View {
    var text: String
    var amount: Int
    var amountText: String
    @State private var isOpen: Bool = false
    var body: some View {
        if isOpen == false {
            RoundedRectangle(cornerRadius: 15 * sizeScreen())
                .foregroundColor(Color("RedTitle"))
                .frame(width: 363 * sizeScreen(), height: 49 * sizeScreen())
                .overlay(
                    HStack{
                        Text(text)
                            .foregroundColor(.white)
                            .font(.custom("Inter-Regular", size: 20 * sizeScreen()))
                        Spacer()
                        Image("moreBox")
                            .resizable()
                            .frame(width: 32 * sizeScreen(), height: 32 * sizeScreen())
                            .onTapGesture {
                                isOpen.toggle()
                            }
                    }
                        .padding()
                )
        }else{
            RoundedRectangle(cornerRadius: 15 * sizeScreen())
                .foregroundColor(Color("RedTitle"))
                .frame(width: 363 * sizeScreen(), height: 108 * sizeScreen())
                .overlay(
                    VStack{
                        HStack{
                            Text(text)
                                .foregroundColor(.white)
                                .font(.custom("Inter-Regular", size: 20 * sizeScreen()))
                            Spacer()
                            Image("moreOpenBox")
                                .resizable()
                                .frame(width: 32 * sizeScreen(), height: 32 * sizeScreen())
                                .onTapGesture {
                                    isOpen.toggle()
                                }
                        }
                        Spacer()
                        Text("\(amount) \(amountText)")
                            .foregroundColor(.white)
                            .font(.custom("Inter-Bold", size: 25 * sizeScreen()))
                    }
                        .padding()
                )
        }
    }
}

#Preview {
    EachStatView(text: "Highest score in one game", amount: 200, amountText: "points")
}
