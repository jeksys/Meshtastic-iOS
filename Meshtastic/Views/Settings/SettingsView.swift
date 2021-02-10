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
    var manager : MeshtasticManager!
    @State private var peripheral: CBPeripheral? = nil
    
    @Binding var meshDevices: [MeshDevice]
    @Binding var devices: [DeviceInfo]
    @State private var showConnectDeviceAlert = false
    @State private var showDisconnectDeviceAlert = false

    @State var reloadView: String?
    
    init(meshDevices: Binding<[MeshDevice]>, devices: Binding<[DeviceInfo]>) {
        self._meshDevices = meshDevices
        self._devices = devices
        manager = MeshtasticManager()
        manager.delegate = self
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Connected BLE Device")
                    List {
                        ForEach(devices) { device in
                            if device.isConnected {
                                DeviceView(device: device)
                                    .onTapGesture {
                                        showDisconnectDeviceAlert = true
                                    }
                                    .alert(isPresented: $showDisconnectDeviceAlert) { () -> Alert in
                                        return connectDeviceAlert(device: device)
                                    }
                            }
                        }
                    }
                }
                Section {
                    Text("BLE Devices")
                    List {
                        ForEach(devices) { device in
                            if !device.isConnected {
                                DeviceView(device: device)
                                    .onTapGesture {
                                        showConnectDeviceAlert = true
                                    }
                                    .alert(isPresented: $showConnectDeviceAlert) { () -> Alert in
                                        return connectDeviceAlert(device: device)
                                    }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Settings"))
        }
    }
    
    private func connectDeviceAlert(device: DeviceInfo) -> Alert {
        let deviceName = device.name

        if device.isConnected {
            return Alert(title: Text("Disconnect Device"), message: Text("\(deviceName)"), primaryButton: .destructive(Text("Disconnect"), action: {
                showDisconnectDeviceAlert = false
                disconnectDevice(device: device)
            }), secondaryButton: .default(Text("Cancel")))
        } else {
            return Alert(title: Text("Connect Device"), message: Text("\(deviceName)"), primaryButton: .default(Text("Connect"), action: {
                showConnectDeviceAlert = false
                connectDevice(device: device)
            }), secondaryButton: .default(Text("Cancel")))
        }
    }

    private func disconnectDevice(device: DeviceInfo) {
        guard let peripheral = device.peripheral else {
            return
        }
        manager.disconnect(peripheral: peripheral)
    }

    private func connectDevice(device: DeviceInfo) {
        guard let peripheral = device.peripheral else {
            return
        }
        self.peripheral = peripheral
        manager.connect(peripheral: peripheral)
    }

    private func readFromDevice(device: DeviceInfo) {
        guard let peripheral = device.peripheral else {
            return
        }
        manager.startConfig(peripheral: peripheral)
    }

}

extension SettingsView: MeshtasticManagerUpdating {
    
    func didReceiveConfig() {
        Log("")
    }
    
    func didDiscoverDevice(name: String?, peripheral: CBPeripheral, RSSI: NSNumber) {
        Log("😺 😺 😺 \(RSSI): \(String(describing: name));\n\(String(describing: peripheral.name))")
        let device = DeviceInfo(id: peripheral.identifier.uuidString, name: peripheral.name ?? "N/A", lastTime: Date(), location: nil)
        device.peripheral = peripheral
        device.rssi = RSSI.doubleValue
        devices.append(device)
    }
    
    func didConnect(to peripheral: CBPeripheral) {
        reloadView = UUID().uuidString
        Log("\(peripheral)")
        
        let newDev = devices
        devices = newDev
    }
    
    func didDisconnect(to peripheral: CBPeripheral) {
        reloadView = UUID().uuidString
        Log("\(peripheral)")
        
        let newDev = devices
        devices = newDev
    }

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(meshDevices: .constant(MeshDevice.data), devices: .constant([DeviceInfo.stub()]))
    }
}
