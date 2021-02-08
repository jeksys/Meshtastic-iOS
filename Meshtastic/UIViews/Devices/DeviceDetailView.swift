//
//  DeviceDetailView.swift
//  Meshtastic
//
//  Created by Evgeny Yagrushkin on 2021-02-07.
//

import SwiftUI

struct DeviceDetailView: View {
    @Binding var device: DeviceInfo
    
    var body: some View {
        VStack{
            DeviceView(device: device)
            .padding()
            if let location = device.location {
                MapLocationView(location: location)
            }
        }
    }
}

struct DeviceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceDetailView(device: .constant(DeviceInfo.stub()))
    }
}

import MapKit
import SwiftUI

struct MapLocationView: View {
    @State var location: CLLocation

    var body: some View {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        Map(coordinateRegion: .constant(region))
    }
}
