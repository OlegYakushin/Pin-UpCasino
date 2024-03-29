//
//  BackgroundView.swift
//  Pin-UpCasino
//
//  Created by Oleg Yakushin on 3/28/24.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("GreenOne").opacity(0.65), Color("RedOne").opacity(0.65)]), startPoint: .top, endPoint: .bottom)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
