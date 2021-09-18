//
//  List.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

struct TodoList: Codable, Identifiable {
    let id: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
    }
}
