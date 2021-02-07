//
//  DeviceInfo.swift
//  Meshtastic
//
//  Created by Evgeny Yagrushkin on 2021-02-07.
//

import CoreLocation

struct DeviceInfo {
    let name: String
    var lastTime: String?
    var location: CLLocation?
}

extension DeviceInfo {
    
    static func stub() {
        DeviceInfo(name: "device name", lastTime: nil, location: nil)
    }
    
}
