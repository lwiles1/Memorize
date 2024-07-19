//
//  ContentView.swift
//  Memorize
//
//  Created by Lucas Wiles on 5/14/24.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    let emojiThemes: [String: [String]] = [
        "Halloween": ["👻", "🕷️", "🎃", "👹", "💀", "❄️", "🧙", "🙀", "😈", "😱", "☠️", "🍭"],
        "Nature": ["🌹", "🍄", "🌿", "🪵", "🌦️", "🌊", "🐣", "🐾", "🌻", "🌲"],
        "CityLife": ["🚗", "✈️", "🏦", "🚦", "🚧", "🧑🏼‍🚒", "🧑🏼‍💻", "💵", "🏗️", "🚎"]
    ]
    
    @State var emojis: Array<String> = []
    @State private var theme = "Halloween"
    @State var cardCount = 10
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
        guard let themeEmojis = emojiThemes[theme] else { return }
        emojis = []
        for emoji in themeEmojis {
            emojis.append(emoji)
            emojis.append(emoji)
        }
        emojis.shuffle()
        cardCount = min(cardCount, themeEmojis.count * 2)
    }
    
    var themesPicker: some View {
        HStack(spacing: 50) {
            Button(action: {
                        theme = "Halloween"
            }) {
                VStack {
                    Image(systemName: "moon.fill")
                    Text("Halloween")
                }
            }
            Button(action: {
                        theme = "CityLife"
            }) {
                VStack {
                    Image(systemName: "car")
                    Text("City Life")
                }
            }
            Button(action: {
                        theme = "Nature"
            }) {
                VStack {
                    Image(systemName: "tree")
                    Text(" Nature ")
                }
            }
        }.onChange(of: theme) {
            cardCount = emojiThemes[theme]?.count ?? 0 * 2
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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
            if !emojis.isEmpty {
                ForEach(emojis.indices, id: \.self) { index in
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
