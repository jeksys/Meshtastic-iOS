//
//  MapView.swift
//  Meshtastic
//
//  Created by Evgeny Yagrushkin on 2020-10-19.
//

import SwiftUI

struct MapView: View {
    @Binding var devices: [DeviceInfo]
    
    var body: some View {
        Text("Map")
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(devices: .constant(DeviceInfo.data))
    }
}

