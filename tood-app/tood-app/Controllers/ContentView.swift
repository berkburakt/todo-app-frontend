//
//  ContentView.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var fetcher = Fetcher()
    @State private var showPopUp = false
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        NavigationView {
            ZStack {
                TodoListView(todoLists: fetcher.todoLists) { index in
                    fetcher.deleteList(index: index)
                } onMove: { source, destination in
                    fetcher.todoLists.move(fromOffsets: source, toOffset: destination)
                }
                if $showPopUp.wrappedValue {
                    PopUpView(onSave: { title in
                        fetcher.addList(title: title)
                        showPopUp = false
                    }, onCancel: {
                        showPopUp = false
                    }, titleText: "Add List")
                }
            }
            .navigationTitle("Todo Lists")
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .environment(\.editMode, $editMode)
            .onAppear(perform: fetcher.getLists)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
