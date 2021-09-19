//
//  TodoListView.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

import SwiftUI

struct TodoListView: View {
    private let onDelete: (_ id: Int) -> ()
    private let onMove: (_ source: IndexSet, _ destination: Int) -> ()
    private let todoLists: [TodoList]
    
    init(todoLists: [TodoList], onDelete: @escaping (_ id: Int) -> (), onMove: @escaping (_ source: IndexSet, _ destination: Int) -> ()) {
        self.todoLists = todoLists
        self.onDelete = onDelete
        self.onMove = onMove
    }
    
    var body: some View {
        if todoLists.isEmpty {
            Text("Empty")
                .multilineTextAlignment(.center)
                .font(.system(size: 30))
                .foregroundColor(.gray)
        } else {
            List {
                ForEach(todoLists, id: \.id) { item in
                    HStack {
                        NavigationLink(destination: ItemsView(listId: item.id, title: item.title)) {
                            Text(item.title)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .padding(30)
                    .background(Color.white)
                    .contentShape(Rectangle())
                    .frame(height: 70)
                }
                .onDelete { indexSet in
                    if let index = indexSet.first {
                        onDelete(index)
                    }
                }
                .onMove(perform: onMove)
                .cornerRadius(5)
                .shadow(color: .gray, radius: 10, x: 5, y: 5)
            }
            .listStyle(GroupedListStyle())
            .onAppear {
                UITableView.appearance().backgroundColor = UIColor.systemGroupedBackground
            }
        }
    }
}
