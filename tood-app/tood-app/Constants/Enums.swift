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

enum Endpoints {
    case lists(id: Int? = nil)
    case items(id: Int? = nil)
    
    var value: String {
        switch self {
        case .lists(id: let id):
            guard let id = id else {
                return "/lists"
            }
            return "/lists/\(id)"
        case .items(id: let id):
            guard let id = id else {
                return "/items"
            }
            return "/items/\(id)"
        }
    }
}

enum Constants: String {
    case BASE_URL = "http://localhost:3000"
}
