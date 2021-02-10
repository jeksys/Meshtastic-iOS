//
//  DevicesView.swift
//  Meshtastic
//
//  Created by Evgeny Yagrushkin on 2020-10-19.
//

import SwiftUI

struct DeviceList: View {
    @Binding var devices: [MeshDevice]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    List {
                        ForEach(devices) { device in
                            MeshDeviceView(device: device)
//                            NavigationLink(destination: DeviceDetailView(device: binding(for: device))) {
//                                DeviceView(device: device)
//                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Devices"))
        }
    }
    
//    private func binding(for devices: DeviceInfo) -> Binding<MeshDevice> {
//        guard let index = devices.firstIndex(where: { $0.id == devices.id }) else {
//            fatalError("Can't find scrum in array")
//        }
//        return devices[index]
//    }

}

struct DevicesView_Previews: PreviewProvider {
    
    static var previews: some View {
        DeviceList(devices: .constant(MeshDevice.data))
    }
}

extension MeshDevice {
    static var data: [MeshDevice] {
        [MeshDevice.stub(), MeshDevice.stub()]
    }
}

