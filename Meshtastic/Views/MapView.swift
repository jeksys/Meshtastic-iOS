//
//  MapView.swift
//  Meshtastic
//
//  Created by Evgeny Yagrushkin on 2020-10-19.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapView: View {
    @Binding var devices: [MeshDevice]
    
    var body: some View {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 49.0, longitude: -123.0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        Map(coordinateRegion: .constant(region))
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(devices: .constant(MeshDevice.data))
    }
}

