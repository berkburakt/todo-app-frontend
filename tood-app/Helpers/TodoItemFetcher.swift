//
//  Fetcher.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

import SwiftUI

class TodoItemFetcher: ObservableObject {
    @Published var todoItems = [TodoItem]()
    private let listId: Int
    
    init(listId: Int) {
        self.listId = listId
    }
    
    func getItems() {
        let url = "\(Constants.BASE_URL)\(Endpoints.lists(id: listId))"
        
        URLSession.request(
            url: url,
            expecting: [TodoItem].self) { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.todoItems = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func markItem(id: Int) {
        let url = "\(Constants.BASE_URL)\(Endpoints.items(id: id))"
        
        URLSession.put(
            url: url) { result in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    self.getItems()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addItem(title: String) {
        let url = "\(Constants.BASE_URL)\(Endpoints.lists(id: listId))"
        let item = Item(title: title)
        
        URLSession.post(
            url: url,
            model: item) { result in
            switch result {
            case .success():
                self.getItems()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setItems(items: [TodoItem]) {
        DispatchQueue.main.async {
            self.todoItems = items
        }
    }
    
    func deleteItem(index: Int) {
        let id = todoItems[index].id
        let url = "\(Constants.BASE_URL)\(Endpoints.items(id: id))"
        
        URLSession.delete(
            url: url) { result in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    self.todoItems.remove(at: index)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
