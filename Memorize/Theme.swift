//
//  Theme.swift
//  Memorize
//
//  Created by Lucas Wiles on 9/10/24.
//

import Foundation
import SwiftUI

struct Theme {
    var name: String
    var emojis: [String]
    var numPairs: Int?
    var color: Color
}

let themes: [Theme] = [
    Theme(name: "Halloween",
          emojis: ["👹","👻","☠️","🤖","👽","🤠","🔪","🩸","🤡","🕸️","🎃","😱"],
          numPairs: 8,
          color: .orange
         ),
    Theme(name: "Flags",
          emojis: ["🇺🇸","🏴󠁧󠁢󠁥󠁮󠁧󠁿","🇫🇷","🇮🇸","🇫🇷","🇮🇹","🇬🇷","🇹🇷","🇩🇪","🇳🇱","🇵🇹","🇪🇸"],
          numPairs: 8,
          color: .blue
          ),
    Theme(name: "Animals",
          emojis: ["🐄","🐈‍⬛","🐎","🐍","🐝","🦥","🐒","🦇","🦉","🐳","🦍","🐿️"],
          numPairs: 8,
          color: .red
         ),
    Theme(name: "Nature",
          emojis: ["🌳","🌿","🌵","🍄","🌹","🍁","🍀","🪵","🌴","🐚","🪻","🪸"],
          numPairs: 8,
          color: .green
         ),
    Theme(name: "Fruit",
          emojis: ["🍎","🍊","🍌","🍉","🍇","🍓","🥝","🍍","🥭","🍑","🫐","🍐"],
          numPairs: 8,
          color: .purple
         ),
    Theme(name: "Faces",
          emojis: ["😂","😤","🫠","🤩","🥸","🙂‍↔️","🥱","🫨","🤧","😎","🥳","🤤"],
          numPairs: 8,
          color: .yellow
         )
]
