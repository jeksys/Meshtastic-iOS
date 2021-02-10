//
//  ChatView.swift
//  Meshtastic
//
//  Created by Evgeny Yagrushkin on 2020-10-19.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Chat message")
                }
            }
            .navigationBarTitle(Text("Chat"))
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
