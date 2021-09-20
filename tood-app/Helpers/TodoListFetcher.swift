//
//  Fetcher.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

import SwiftUI

class TodoListFetcher: ObservableObject {
    @Published var todoLists = [TodoList]()
    
    func getLists() {
        let url = "\(Constants.BASE_URL)\(Endpoints.lists())"
        
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
        let url = "\(Constants.BASE_URL)\(Endpoints.lists())"
        let item = Item(title: title)
        
        URLSession.post(
            url: url,
            model: item) { result in
            switch result {
            case .success():
                self.getLists()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func deleteList(index: Int) {
        let id = todoLists[index].id
        let url = "\(Constants.BASE_URL)\(Endpoints.lists(id: id))"
        
        URLSession.delete(
            url: url) { result in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    self.todoLists.remove(at: index)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
