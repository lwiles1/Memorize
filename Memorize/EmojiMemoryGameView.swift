//
//  ContentView.swift
//  Memorize
//
//  Created by Lucas Wiles on 5/14/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    @State var emojis: Array<String> = []
    @State private var theme = "Halloween"
    @State var cardCount = 10
    @State var begin: Bool = false
    
    var body: some View {
        VStack {
            title
            Text("\(viewModel.theme.name)")
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
            HStack {
                Button("New Game"){
                    viewModel.newGame()
                }
                Spacer()
                Text("Score: \(viewModel.score)")
                Spacer()
                Button("Shuffle") {
                    viewModel.shuffle()
                }
            }
        }
        .padding()
    }
    
    var title: some View {
        Text("Memorize")
            .font(.title)
            .fontWeight(.bold)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
        }
        .foregroundColor(.orange)
    }
    
    /*
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
    */
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
