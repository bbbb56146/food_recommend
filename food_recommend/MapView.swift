//
//  MapView.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/31.
//

import SwiftUI
import MapKit

struct MapView : View {
    //서울 좌표
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    var locManager = CLLocationManager()

    var body: some View {
        
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
    }
}
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
