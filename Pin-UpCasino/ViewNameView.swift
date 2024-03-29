//
//  ViewNameView.swift
//  Pin-UpCasino
//
//  Created by Oleg Yakushin on 3/28/24.
//

import SwiftUI

struct ViewNameView: View {
    var text:String
    var body: some View {
        RoundedRectangle(cornerRadius: 15 * sizeScreen())
            .foregroundColor(Color("RedTitle"))
            .frame(width: 291 * sizeScreen(), height: 110 * sizeScreen())
            .shadow(
               color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 5
             )
            .overlay(
            Text(text)
                .textCase(.uppercase)
                .foregroundColor(.white)
                .font(.custom("Inter-ExtraBold", size: 30 * sizeScreen()))
            )
           
    }
}

#Preview {
    ViewNameView(text: "Pong Up")
}
