//
//  Item.swift
//  todo
//
//  Created by Lutaka Muyoba Chihota on 10/14/22.
//

import Foundation

struct TodoItem:Identifiable,Codable{
    let id = UUID()
    var name:String
}
