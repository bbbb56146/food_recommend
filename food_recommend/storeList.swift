//
//  storeListData.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/31.
//

import SwiftUI

struct StoreList {
    let name: String
    let mapview: String
    let len : Double
}

extension StoreList {
    // 정적함수를 이용하여 모든 데이터를 가져옵니다.
    static func all() -> [StoreList] {
        return [
            StoreList(name: "가게1", mapview: "그림1", len: 1.25),
            StoreList(name: "가게2", mapview: "그림1", len: 0.25),
            StoreList(name: "가게3", mapview: "그림1", len: 1.00),
        ]
    }
}
