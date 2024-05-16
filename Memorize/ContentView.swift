//
//  ContentView.swift
//  Memorize
//
//  Created by Lucas Wiles on 5/14/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView()
            CardView()
            CardView()
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 15).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 15).strokeBorder(lineWidth: 2)
                Text("👻").font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.orange)
            }
        }
    }
}

#Preview {
    ContentView()
}
