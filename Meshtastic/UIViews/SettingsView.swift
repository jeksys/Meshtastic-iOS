//
//  SettingsView.swift
//  Meshtastic
//
//  Created by Evgeny Yagrushkin on 2020-10-19.
//

import SwiftUI
import CoreBluetooth

/*
 Connect device button
 Disconnect device button
 
 
 */

struct SettingsView: View {
    @State private var score = 0

    var manager : MeshtasticManager!
    @State private var peripheral: CBPeripheral? = nil
    
    init() {
        manager = MeshtasticManager()
        manager.delegate = self
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(peripheral?.name ?? "N/A")")
                Button(action: {
                }) {
                    Text("Connect device")
                }
            }
                .navigationBarTitle("Settings", displayMode: .inline)
                .navigationBarItems(
                    trailing:
                        Button("S") {
                            self.score += 1
                        }
                )
        }
    }
}

extension SettingsView: MeshtasticManagerUpdating {
    func didReceiveConfig() {
    }
    
    func didDiscoverDevice(name: String?, peripheral: CBPeripheral, RSSI: NSNumber) {
        Log("\(RSSI): \(String(describing: name)); \(peripheral)")
        self.peripheral = peripheral
        manager.connect(peripheral: peripheral)
    }
    
    func didConnect(to peripheral: CBPeripheral) {
        print(peripheral)
    }
    
    func didDisconnect(to peripheral: CBPeripheral) {
        print(peripheral)
    }

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
