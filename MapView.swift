//
//  MapView.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/31.
//

import SwiftUI
import MapKit
import CoreLocation

struct Place: Identifiable {
    let id = UUID()
    var name: String
    var latitude: Double
    var longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct MapView : View {
    //서울 좌표
    @Binding var isTapped :Bool
    @Binding var tappedStoreName : String
    var stores : [Store]
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5514516, longitude: 126.943000), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//    var locManager : CLLocationManager = CLLocationManager()
//    locManager.requestWhenInUseAuthorization()
        
    var body: some View {
        //place 만들기
        let pins = self.makePlaces()
        
        //user location 표시 되도록 하기,,,
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: pins){
            item in
            
            MapMarker(coordinate: item.coordinate, tint: tappedStoreName == item.name ? .red : .black)
        }
            .edgesIgnoringSafeArea(.all)
    }
    
    func makePlaces() -> [Place]{
        var places = [Place]()
        for store in stores{
            places.append(Place(name: store.name, latitude: store.Y, longitude: store.X))
        }
        return places
    }
}
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(isTapped:.constant(false) , tappedStoreName: .constant("") , stores: [Store(id: "343", name: "test_store name", addr: "101", len: 0.17, food: "피자", X: 126.943000, Y: 37.5514516)])
    }
}
