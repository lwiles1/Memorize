//
//  ContentView.swift
//  Memorize
//
//  Created by Lucas Wiles on 5/14/24.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["👻", "🕷️", "🎃", "👹", "💀", "❄️", "🧙", "🙀", "😈", "😱", "☠️", "🍭"]
    let natu: Array<String> = ["🌹", "🍄", "🌿", "🪵", "🌦️", "🌊", "🌙", "🐣", "🐾", "🌺", "🌻", "🌲"]
    let city: Array<String> = ["🚗", "✈️", "🏦", "💒", "🚦", "🚧", "🧑🏼‍🚒", "🧑🏼‍💻", "💵", "🌆", "🏗️", "🚎"]
    
    enum Theme: String, CaseIterable, Identifiable {
        case halloween, nature, cityLife
        var id: Self { self }
    }
    
    @State private var selectedTheme: Theme = .halloween
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            title
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
            themesPicker
        }
        .padding()
    }
    
    func cardCountAdjusters(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var themesPicker: some View {
        VStack {
            Text("Themes:")
            Picker("Theme", selection: $selectedTheme) {
                ForEach(Theme.allCases) { theme in
                    Text(theme.rawValue.capitalized)
                }
            }.pickerStyle(.segmented)
        }
    }
    
    var title: some View {
        Text("Memorize")
            .font(.title)
            .fontWeight(.bold)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardRemover: some View {
        cardCountAdjusters(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    var cardAdder: some View {
        cardCountAdjusters(by: +1, symbol: "rectangle.stack.fill.badge.plus")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
