//
//  MapView.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/31.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView : View {
    //서울 좌표
    @Binding var isTapped :Bool
    @Binding var tappedStoreName : String
    @Binding var stores : [StoreInfo]
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5514516, longitude: 126.943000), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//    var locManager : CLLocationManager = CLLocationManager()
//    locManager.requestWhenInUseAuthorization()
        
    var body: some View {
        
        //user location 표시 되도록 하기,,,
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: stores){
            item in
            
            MapMarker(coordinate: CLLocationCoordinate2D(latitude: Double(item.y) ?? 1, longitude: Double(item.x) ?? 1)
, tint: tappedStoreName == item.place_name ? .red : .black)
        }
            .edgesIgnoringSafeArea(.all)
    }
    
}
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(isTapped:.constant(false) , tappedStoreName: .constant("aa") , stores: .constant([StoreInfo(address_name: "test", category_group_code: "test", category_group_name: "test",category_name: "test",distance: "1",id: "test",phone: "test",place_name : "test",place_url: "http:127.0.0.1:5000",road_address_name: "test",x:"37.00",y: "126.00")]))
    }
}

