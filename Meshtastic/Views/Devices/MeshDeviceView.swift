//
//  MeshDeviceView.swift
//  Meshtastic
//
//  Created by Evgeny Yagrushkin on 2021-02-08.
//

import SwiftUI

struct MeshDeviceView: View {
    var device: MeshDevice
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "person")
                    .font(.system(size: 12))
                    .lineLimit(0)
                Text(device.name)
            }
        }
        .padding()
    }
}

struct MeshDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        MeshDeviceView(device: MeshDevice.stub())
    }
}
