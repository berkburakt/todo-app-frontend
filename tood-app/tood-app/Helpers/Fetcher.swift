//
//  Fetcher.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

import SwiftUI

class Fetcher: ObservableObject {
    @Published var todoLists = [TodoList]()
    
    func getLists() {
        let url = "\(Constants.BASE_URL)\(Endpoints.LISTS)"
        
        URLSession.request(
            url: url,
            expecting: [TodoList].self) { result in
            switch result {
            case .success(let lists):
                DispatchQueue.main.async {
                    self.todoLists = lists
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addList(title: String) {
        let url = "\(Constants.BASE_URL)\(Endpoints.LISTS)"
        let item = Item(title: title)
        
        URLSession.post(
            url: url,
            model: item) { result in
            switch result {
            case .success(let isSuccess):
                if isSuccess {
                    self.getLists()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
