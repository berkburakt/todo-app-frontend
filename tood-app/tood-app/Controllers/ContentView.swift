//
//  ContentView.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var fetcher = TodoListFetcher()
    @State private var showPopUp = false
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        NavigationView {
            BaseView(content: {
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
            },
            showPopUp: $showPopUp,
            navigationTitle: "Todo Lists")
            .onAppear(perform: fetcher.getLists)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
