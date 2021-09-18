//
//  PopUpView.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

import SwiftUI

struct PopUpView: View {
    let onSave: (_ title: String) -> ()
    let onCancel: () -> ()
    let titleText: String
    @State private var title: String = ""

    var body: some View {
        ZStack {
            Color.white
            VStack(alignment: .center, spacing: 20) {
                Text(titleText)
                
                TextField("Enter a title...", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing], 10)
                                
                HStack(alignment: .center, spacing: 0) {
                    Button("Save") {
                        onSave($title.wrappedValue)
                    }
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity)
                    
                    Button("Cancel") {
                        onCancel()
                    }
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity)
                }
            }.padding(5)
        }
        .frame(width: 300, height: 150)
        .cornerRadius(20).shadow(radius: 20)
    }
    
    init(onSave: @escaping (_ title: String) -> (), onCancel: @escaping () -> (), titleText: String) {
        self.onSave = onSave
        self.onCancel = onCancel
        self.titleText = titleText
    }
}
