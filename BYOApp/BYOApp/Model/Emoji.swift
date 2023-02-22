//
//  Emoji.swift
//  BYOApp
//
//  Created by Sebastian Guiscardo on 2/22/23.
//

import Foundation

class Emoji {
    
    let name: String
    let category: String
    let group: String
    
    init(name: String, category: String, group: String) {
        self.name = name
        self.category = category
        self.group = group
    }
}

extension Emoji {
    
    enum Keys: String {
        case name
        case category
        case group
    }
    
    convenience init?(emojiDictionary: [String : Any]) {
        guard let name = emojiDictionary[Keys.name.rawValue] as? String,
              let category = emojiDictionary[Keys.category.rawValue] as? String,
              let group = emojiDictionary[Keys.group.rawValue] as? String else { return nil}
        
        self.init(name: name, category: category, group: group)
    }
}
