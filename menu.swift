//
//  FoodList.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/31.
//

struct FoodList : Codable, Identifiable {
    var id: String
    var name: String
    var imageUrl: String
    var totalNum : Int
}

extension FoodList {
    // 정적함수를 이용하여 모든 데이터를 가져옵니다.
    static func all() -> [FoodList] {
        return [
            FoodList(id: "1", name: "팬케이크", imageUrl: "pancakes-2291908_640", totalNum: 4),
            FoodList(id: "2", name: "피자", imageUrl: "plate-2802332_640", totalNum: 22),
            FoodList(id: "3", name: "연어 스테이크", imageUrl: "salmon-518032_640", totalNum: 8)
        ]
    }
}

struct User_menu : Codable{
    var name: String
    var freq: Int
}

struct SendJSON : Codable{
    var food_freq : User_menu
    var user_feedback : User_menu
}

//let encoder = JSONEncoder()
//encoder.outputFormatting = [.sortedLeys, .prettyPrinted]
//let
