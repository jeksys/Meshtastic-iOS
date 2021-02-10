//
//  MainView.swift
//  Meshtastic
//
//  Created by Evgeny Yagrushkin on 2020-10-19.
//

import SwiftUI

struct AppView: View {
    @State private var meshDevices = [MeshDevice]()
    @State private var bleDevices = [DeviceInfo]()

    init() {
        setDebugLevel(level: .debug, for: .generic)
        setDebugLevel(level: .info, for: .network)
        setDebugLevel(level: .debug, for: .mesh)
    }
    
    var body: some View {
        TabView {
            ChatView()
                .tabItem {
                    Image(systemName: "message.circle")
                    Text("Chat")
            }.tag(0)

            MapView(devices: $meshDevices)
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
            }.tag(1)

            DeviceList(devices: $meshDevices)
                .tabItem {
                    Image(systemName: "server.rack")
                    Text("Devices")
            }.tag(2)

            SettingsView(meshDevices: $meshDevices, devices: $bleDevices)
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

