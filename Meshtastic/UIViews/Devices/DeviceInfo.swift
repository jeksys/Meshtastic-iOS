//
//  DeviceInfo.swift
//  Meshtastic
//
//  Created by Evgeny Yagrushkin on 2021-02-07.
//

import CoreLocation

struct DeviceInfo: Identifiable {
    let id: String
    let name: String
    var lastTime: Date?
    var location: CLLocation?
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
    
}

extension DeviceInfo {
    
    static func stub() -> DeviceInfo {
        DeviceInfo(id: UUID().uuidString, name: "device name", lastTime: Date(), location: CLLocation(latitude: 49.0, longitude: -123.0))
    }
    
}
