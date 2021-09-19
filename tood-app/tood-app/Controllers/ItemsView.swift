//
//  ContentView.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

import SwiftUI

struct ItemsView: View {
    @ObservedObject private var fetcher: TodoItemFetcher
    @State private var showPopUp = false
    @State private var editMode = EditMode.inactive
    private let listId: Int
    private let title: String
    
    init(listId: Int, title: String) {
        self.listId = listId
        self.title = title
        fetcher = TodoItemFetcher(listId: listId)
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all)
            ItemListView(todoItems: fetcher.todoItems) { index in
                fetcher.deleteItem(index: index)
            } onMove: { source, destination in
                fetcher.todoItems.move(fromOffsets: source, toOffset: destination)
            } onTap: { id in
                fetcher.markItem(id: id)
            }
            if $showPopUp.wrappedValue {
                PopUpView(onSave: { title in
                    fetcher.addItem(title: title)
                    showPopUp = false
                }, onCancel: {
                    showPopUp = false
                }, titleText: "Add Item")
            }
        }
        .navigationTitle(title)
        .navigationBarItems(leading: EditButton(), trailing: addButton)
        .environment(\.editMode, $editMode)
        .onAppear {
            fetcher.getItems()
        }
    }
    
    private var addButton: some View {
        switch editMode {
        case .inactive:
            return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
        default:
            return AnyView(EmptyView())
        }
    }
    
    private func onAdd() {
        showPopUp = true
    }
}
