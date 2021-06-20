//
//  ContentView.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/30.
//
import SwiftUI

struct ContentView: View {
   @State private var selection = 1
    var body: some View {
        TabView(selection: $selection) {
            analyzeView().tabItem {
                Image(systemName: "eyedropper")
                Text("분석").font(.headline)
            }.tag(1)
            todayRecommendView().tabItem {
                Image(systemName: "map")
                Text("추천").font(.largeTitle)
            }.tag(2)
            
        }
        //.tintColor(Color(#colorLiteral(red: 0.9764705882, green: 0.7450980392, blue: 0.1568627451, alpha: 1)))

       
    }
    //view end
}
//body end

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
