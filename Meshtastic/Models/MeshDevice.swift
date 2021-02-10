//
//  MeshDevice.swift
//  Meshtastic
//
//  Created by Evgeny Yagrushkin on 2021-02-08.
//

import CoreLocation

class MeshDevice: Identifiable, ObservableObject {
    let id: String
    let name: String
    @Published var location: CLLocation? = nil

    init(id: String, name: String, location: CLLocation?) {
        self.id = id
        self.name = name
        self.location = location
    }
}

extension MeshDevice {
    
    static func stub() -> MeshDevice {
        MeshDevice(id: UUID().uuidString, name: "mesh name", location: CLLocation(latitude: 49.0, longitude: -123.0))
    }
    
}

extension MeshDevice: Equatable {
    
    static func == (lhs: MeshDevice, rhs: MeshDevice) -> Bool {
        return lhs.id == rhs.id
    }
    
}
