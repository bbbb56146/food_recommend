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
                Image(systemName: "1.circle")
                Text("분석")
                .font(.headline) }.tag(1)
            todayRecommendView().tabItem {
                Image(systemName: "2.circle")
                Text("추천").font(.largeTitle) }.tag(2)
            
        }

       
    }
    //view end
}
//body end

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
