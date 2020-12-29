//
//  ShoppingList.swift
//  ShoppingLIst
//
//  Created by Daniel Montecillo on 2020-12-29.
//

import Foundation

class ShoppingList: Codable {
    var name: String
    var items: [Item] {
        didSet {
            onUpdate()
        }
    }
    
    // On Update is function and declared with callback syntax ()
    var onUpdate: () -> () = {}
    
    init(name: String, items:[Item] = []) {
        self.name = name
        self.items = items
    }
    
    convenience init(name: String, items: [Item], onUpdate: @escaping () -> ()) {
        self.init(name: name, items: items)
        self.onUpdate = onUpdate
    }
    

    func add(_ item: Item) {
        self.items.append(item)
    }
    
    func remove(at index: Int) {
        self.items.remove(at: index)
    }
    
    func swapItem(_ fromIndex: Int, _ toIndex: Int) {
        self.items.swapAt(fromIndex, toIndex)
    }
    
    func toggleCheckItem(atIndex index: Int) {
        items[index] = items[index].toggleCheck()
    }
    private enum CodingKeys: String, CodingKey {
        case name
        case items
    }
    
}

