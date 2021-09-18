//
//  TodoListView.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

import SwiftUI

struct TodoListView: View {
    let onDelete: (_ id: Int) -> ()
    let onMove: (_ source: IndexSet, _ destination: Int) -> ()
    let todoLists: [TodoList]
    
    var body: some View {
        if todoLists.isEmpty {
            Text("Empty")
                .multilineTextAlignment(.center)
                .font(.system(size: 30))
                .foregroundColor(.gray)
        } else {
            List {
                ForEach(todoLists, id: \.id) { item in
                    Text(item.title)
                        .padding()
                }
                .onDelete { indexSet in
                    if let index = indexSet.first {
                        onDelete(index)
                    }
                }
                .onMove(perform: onMove)
            }
            
        }
    }
    
    init(todoLists: [TodoList], onDelete: @escaping (_ id: Int) -> (), onMove: @escaping (_ source: IndexSet, _ destination: Int) -> ()) {
        self.todoLists = todoLists
        self.onDelete = onDelete
        self.onMove = onMove
    }
}