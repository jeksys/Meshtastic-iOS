//
//  DeviceInfo.swift
//  Meshtastic
//
//  Created by Evgeny Yagrushkin on 2021-02-07.
//

import CoreLocation
import CoreBluetooth


class DeviceInfo: Identifiable, ObservableObject {
    let id: String
    let name: String
    @Published var lastTime: Date?
    @Published var location: CLLocation? = nil
    @Published var peripheral: CBPeripheral? = nil
    @Published var rssi: Double? = nil
    
    init(id: String, name: String, lastTime: Date, location: CLLocation?) {
        self.id = id
        self.name = name
        self.lastTime = lastTime
        self.location = location
    }
}

extension DeviceInfo {
    
    var timeString: String? {
        guard let lastTime = lastTime else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: lastTime)
    }
    
    var isConnected: Bool {
        peripheral?.state ?? .disconnected == CBPeripheralState.connected
    }
    
}

extension DeviceInfo {
    
    static func stub() -> DeviceInfo {
        DeviceInfo(id: UUID().uuidString, name: "device name", lastTime: Date(), location: CLLocation(latitude: 49.0, longitude: -123.0))
    }
    
}

extension DeviceInfo: Equatable {
    
    static func == (lhs: DeviceInfo, rhs: DeviceInfo) -> Bool {
        return lhs.id == rhs.id
    }
    
}
