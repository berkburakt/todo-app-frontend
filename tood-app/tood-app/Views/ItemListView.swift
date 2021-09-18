//
//  TodoListView.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

import SwiftUI

struct ItemListView: View {
    let onDelete: (_ id: Int) -> ()
    let onMove: (_ source: IndexSet, _ destination: Int) -> ()
    let onTap: (_ id: Int) -> ()
    let todoItems: [TodoItem]
    
    var body: some View {
        if todoItems.isEmpty {
            Text("Empty")
                .multilineTextAlignment(.center)
                .font(.system(size: 30))
                .foregroundColor(.gray)
        } else {
            List {
                ForEach(todoItems, id: \.id) { item in
                    HStack {
                        Text(item.title)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        
                        if item.isDone {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .frame(maxHeight: .infinity)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .onTapGesture {
                        onTap(item.id)
                    }
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
    
    init(todoItems: [TodoItem], onDelete: @escaping (_ id: Int) -> (), onMove: @escaping (_ source: IndexSet, _ destination: Int) -> (), onTap: @escaping (_ id: Int) -> ()) {
        self.todoItems = todoItems
        self.onDelete = onDelete
        self.onMove = onMove
        self.onTap = onTap
    }
}
