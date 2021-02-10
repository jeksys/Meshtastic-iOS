//
//  DeviceView.swift
//  Meshtastic
//
//  Created by Evgeny Yagrushkin on 2021-02-07.
//

import SwiftUI

struct DeviceView: View {
    var device: DeviceInfo
    
    var body: some View {
        VStack{
            HStack{
                if device.isConnected {
                    Image(systemName: "checkmark")
                }
                Image(systemName: "person")
                    .font(.system(size: 12))
                    .lineLimit(0)
                Text(device.name)
                VStack(alignment: .leading) {
                    HStack{
                        if let lastTime = device.timeString {
                            Image(systemName: "timer")
                            Text("\(lastTime)")
                                .lineLimit(1)
                                .font(.system(size: 12))
                        }
                    }
                    HStack{
                        if let location = device.location {
                            Image(systemName: "location")
                            Text("\(String(format: "%.2f", location.coordinate.latitude))")
                                .font(.system(size: 12))
                                .lineLimit(1)
                            Text("\(String(format: "%.2f", location.coordinate.longitude))")
                                .font(.system(size: 12))
                                .lineLimit(1)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct DeviceView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceView(device: DeviceInfo.stub())
    }
}
