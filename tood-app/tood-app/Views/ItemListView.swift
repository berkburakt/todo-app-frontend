//
//  TodoListView.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

import SwiftUI

struct ItemListView: View {
    private let onDelete: (_ id: Int) -> ()
    private let onMove: (_ source: IndexSet, _ destination: Int) -> ()
    private let onTap: (_ id: Int) -> ()
    private let todoItems: [TodoItem]
    
    init(todoItems: [TodoItem], onDelete: @escaping (_ id: Int) -> (), onMove: @escaping (_ source: IndexSet, _ destination: Int) -> (), onTap: @escaping (_ id: Int) -> ()) {
        self.todoItems = todoItems
        self.onDelete = onDelete
        self.onMove = onMove
        self.onTap = onTap
    }
    
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
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        
                        if item.isDone {
                            Image(systemName: "checkmark.circle")
                                .frame(maxHeight: .infinity)
                        }
                    }
                    .padding(30)
                    .background(Color.white)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if(!item.isDone) {
                            onTap(item.id)
                        }
                    }
                    .frame(height: 70)
                }
                .onDelete { indexSet in
                    if let index = indexSet.first {
                        onDelete(index)
                    }
                }
                .onMove(perform: onMove)
                .cornerRadius(5)
                .shadow(color: .gray, radius: 5, x: -5, y: 5)
                .listRowBackground(Color.clear)
            }
        }
    }
}
