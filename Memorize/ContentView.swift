//
//  ContentView.swift
//  Memorize
//
//  Created by Lucas Wiles on 5/14/24.
//

import SwiftUI

struct ContentView: View {
    
    let emojiThemes: [String: [String]] = [
        "Halloween": ["👻", "🕷️", "🎃", "👹", "💀", "❄️", "🧙", "🙀", "😈", "😱", "☠️", "🍭"],
        "Nature": ["🌹", "🍄", "🌿", "🪵", "🌦️", "🌊", "🌙", "🐣", "🐾", "🌻", "🌲"],
        "CityLife": ["🚗", "✈️", "🏦", "🚦", "🚧", "🧑🏼‍🚒", "🧑🏼‍💻", "💵", "🏗️", "🚎"]
    ]
    
    @State var emojis: Array<String> = []
    @State private var theme = "Halloween"
    @State var cardCount = 8
    @State var begin: Bool = false
    
    var body: some View {
        VStack {
            title
            ScrollView {
                cards
            }
            Spacer()
            themesPicker
        }
        .padding()
    }
    
    func randomizeCards() {
        cardCount = emojiThemes[theme]?.count ?? 0
        emojis = []
        for i in 0..<(cardCount / 2) {
            emojis.append(emojiThemes[theme]?[i] ?? "")
            emojis.append(emojiThemes[theme]?[i] ?? "")
            emojis.shuffle()
        }
    }
    
    var themesPicker: some View {
        HStack {
            Button(action: {
                        theme = "Halloween"
            }) {
                VStack {
                    Image(systemName: "moon.fill")
                    Text("Halloween")
                }
            }
            Spacer()
            Button(action: {
                        theme = "CityLife"
            }) {
                VStack {
                    Image(systemName: "car")
                    Text("City Life")
                }
            }
            Spacer()
            Button(action: {
                        theme = "Nature"
            }) {
                VStack {
                    Image(systemName: "tree")
                    Text("Nature")
                }
            }
        }.onChange(of: theme) {
            randomizeCards()
        }.onAppear {
            randomizeCards()
        }
    }
    
    var title: some View {
        Text("Memorize")
            .font(.title)
            .fontWeight(.bold)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            if !emojis.isEmpty {
                ForEach(0..<cardCount, id: \.self) { index in
                    CardView(content: emojis[index])
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
        .foregroundColor(.orange)
    }
    
    func cardCountAdjusters(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset * 2
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 8 || cardCount + offset > emojiThemes[theme]?.count ?? 12)
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
