//
//  DeviceView.swift
//  Meshtastic
//
//  Created by Evgeny Yagrushkin on 2021-02-07.
//

import SwiftUI

struct DeviceView {
    @Binding var device: DeviceInfo
    
    var body: some View {
            VStack {
               Text("text")
            }
        }
}

struct DeviceView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceView(device: .constant(DeviceInfo.stub()))
    }
}

