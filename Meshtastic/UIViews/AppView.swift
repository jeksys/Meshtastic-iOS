//
//  MainView.swift
//  Meshtastic
//
//  Created by Evgeny Yagrushkin on 2020-10-19.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            ChatView()
                .tabItem {
                    Image("main.chat")
                    Text("Chat")
            }.tag(0)
            
            MapView()
                .tabItem {
                    Image("main.maps")
                    Text("Devices")
            }.tag(1)

            DevicesView()
                .tabItem {
                    Image("main.maps")
                    Text("Map")
            }.tag(2)

            SettingsView()
                .tabItem {
                    Image("main.settings")
                    Text("Settings")
            }.tag(3)
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

