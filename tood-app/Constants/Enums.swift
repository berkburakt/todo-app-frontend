//
//  Enums.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

enum NetworkError: Error {
    case invalidUrl
    case invalidData
    case invalidModel
}

struct Endpoints {
    static func lists(id: Int? = nil) -> String {
        guard let id = id else {
            return "/lists"
        }
        return "/lists/\(id)"
    }
    
    static func items(id: Int? = nil) -> String {
        guard let id = id else {
            return "/items"
        }
        return "/items/\(id)"
    }
    
    private init() {}
}

struct Constants {
    static let BASE_URL = "http://localhost:3000"
    
    private init() {}
}
