//
//  Card.swift
//  C_Mega_Menu
//
//  Created by 이성민 on 2023/05/13.
//

import SwiftUI

struct Card: Hashable {
    let caption: String
    let date: String
    let color: Color
    
    static var exapleCards: [Card] {
        let colors: [Color] = [Color(red: 60/255, green: 144/255, blue: 207/255), Color(red: 71/255, green: 141/255, blue: 194/255), Color(red: 82/255, green: 138/255, blue: 181/255), Color(red: 94/255, green: 136/255, blue: 167/255), Color(red: 105/255, green: 133/255, blue: 154/255)]
        let dates = (0...4).map{"Item \($0)"}
        let captions = (0...4).map{"Item \($0)"}
        
        var result = [Card]()
        for i in 0..<captions.count {
            let item = Card(caption: captions[i], date: dates[i], color: colors[i])
            result.append(item)
        }
        
        return result
    }
}
