//
//  MapView.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/31.
//

import SwiftUI
#import <DaumMap/MTMapView.h>

struct MapView : UIViewRepresentable {
    
    func makeUIView(context: Context) -> MTMapView {
        let view = MTMapView(frame: .zero)
        return view
    }
    
    func updateUIView(_ uiView: MTMapView, context: Context) {
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
