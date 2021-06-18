//
//  FoodList.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/31.
//

struct menu : Codable, Identifiable {
    var id: String    
    var name: String
    var imageUrl: String
    var totalNum : Int
}
