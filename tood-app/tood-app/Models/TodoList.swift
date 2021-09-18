//
//  List.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

struct TodoList: Codable, Identifiable {
    let id: Int
    let title: String
    let items: [TodoItem]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case items = "items"
    }
}
