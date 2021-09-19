//
//  BaseView.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

import SwiftUI

struct BaseView<Content>: View where Content: View {
    @State private var editMode = EditMode.inactive
    @Binding private var showPopUp: Bool
    private let content: Content
    private let navigationTitle: String
    
    init(@ViewBuilder content: () -> Content, showPopUp: Binding<Bool>, navigationTitle: String) {
        self.content = content()
        self._showPopUp = showPopUp
        self.navigationTitle = navigationTitle
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all)
            content
        }
        .navigationTitle(navigationTitle)
        .navigationBarItems(leading: EditButton(), trailing: addButton)
        .environment(\.editMode, $editMode)
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
