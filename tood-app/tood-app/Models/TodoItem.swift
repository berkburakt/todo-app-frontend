//
//  Item.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

struct TodoItem: Codable, Identifiable {
    let id: Int
    let listId: Int
    let title: String
    var isDone: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case listId = "list_id"
        case title = "title"
        case isDone = "isdone"
    }
}
