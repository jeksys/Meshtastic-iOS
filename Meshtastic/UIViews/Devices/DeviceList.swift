//
//  DevicesView.swift
//  Meshtastic
//
//  Created by Evgeny Yagrushkin on 2020-10-19.
//

import SwiftUI

struct DeviceList: View {
    @Binding var devices: [DeviceInfo]
    
    var body: some View {
        List {
            ForEach(devices) { device in
                NavigationLink(destination: DeviceDetailView(device: binding(for: device))) {
                    DeviceView(device: device)
                }
            }
        }
        .navigationTitle("Devices")
    }
    
    private func binding(for scrum: DeviceInfo) -> Binding<DeviceInfo> {
        guard let index = devices.firstIndex(where: { $0.id == scrum.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $devices[index]
    }

}

struct DevicesView_Previews: PreviewProvider {
    
    static var previews: some View {
        DeviceList(devices: .constant(DeviceInfo.data))
    }
}

extension DeviceInfo {
    static var data: [DeviceInfo] {
        [DeviceInfo.stub(), DeviceInfo.stub()]
    }
}

