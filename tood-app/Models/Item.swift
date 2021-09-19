//
//  Item.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

struct Item: Codable {    
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
    }
}
