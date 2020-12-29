//
//  Items.swift
//  ShoppingLIst
//
//  Created by Daniel Montecillo on 2020-12-28.
//

import UIKit
import Foundation

class Item: Codable {
    var name: String
    var isChecked: Bool
    init(name: String, isChecked: Bool = false) {
        self.name = name
        self.isChecked = isChecked
    }
    
    static func fake(_ count: Int) -> [Item] {
        var items = [Item]()
        for i in 0...count {
            let item = Item(name: "Item \(i)", isChecked: i % 2 == 0)
            items.append(item)
        }
        return items
    }
    
    // Toggle checkmark
    func toggleCheck() -> Item {
        return Item(name: name, isChecked:  !isChecked)
    }
    
    // Extensionn Array to add teh save method and a class level load method to save and load the items
    // from the UserDefaults:
    
}


// Extension to load the
extension Array where Element == Item {
    func save() {
        let data = try? PropertyListEncoder().encode(self)
        UserDefaults.standard.set(data, forKey: String(describing:
                                                        Element.self))
        UserDefaults.standard.synchronize()
    }
    static func load() -> [Element] {
        if let data = UserDefaults.standard.value(forKey: String(describing: Element.self)) as? Data,
           let items = try? PropertyListDecoder().decode([Element].self, from: data){
            return items
        }
        return []
    }
    
}



