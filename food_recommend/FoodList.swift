//
//  FoodList.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/31.
//

struct FoodList {
    let name: String
    let imageUrl: String
    let totalNum : Int
}

extension FoodList {
    // 정적함수를 이용하여 모든 데이터를 가져옵니다.
    static func all() -> [FoodList] {
        return [
            FoodList(name: "팬케이크", imageUrl: "pancakes-2291908_640", totalNum: 4),
            FoodList(name: "피자", imageUrl: "plate-2802332_640", totalNum: 22),
            FoodList(name: "연어 스테이크", imageUrl: "salmon-518032_640", totalNum: 8),
            
        ]
    }
}
