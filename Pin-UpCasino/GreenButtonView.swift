//
//  GreenButtonView.swift
//  Pin-UpCasino
//
//  Created by Oleg Yakushin on 3/28/24.
//

import SwiftUI

struct GreenButtonView: View {
    var text:String
    var body: some View {
        RoundedRectangle(cornerRadius: 15 * sizeScreen())
            .foregroundColor(Color("GreenOne"))
            .frame(width: 291 * sizeScreen(), height: 72 * sizeScreen())
            .shadow(
               color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 5
             )
            .overlay(
            Text(text)
                .textCase(.uppercase)
                .foregroundColor(.white)
                .font(.custom("Inter-ExtraBold", size: 25 * sizeScreen()))
            )
           
    }
}

#Preview {
    GreenButtonView(text: "play")
}
