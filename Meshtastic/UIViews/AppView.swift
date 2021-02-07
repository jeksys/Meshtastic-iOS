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
                    Image(systemName: "message.circle")
                    Text("Chat")
            }.tag(0)

            MapView()
                .tabItem {
                    Image(systemName: "server.rack")
                    Text("Devices")
            }.tag(1)

            DeviceList()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
            }.tag(2)

            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
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

