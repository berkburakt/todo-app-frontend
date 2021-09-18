//
//  ContentView.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var fetcher = Fetcher()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                }
                
                if fetcher.todoLists.isEmpty {
                    Text("Empty")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                } else {
                    List(fetcher.todoLists) { todoList in
                        Text(todoList.title)
                    }
                }
            }
            .toolbar {
                Button("Add List") {
                    print("Help tapped!")
                }
            }
            .navigationTitle("Todo Lists")
            .onAppear(perform: fetcher.getLists)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
