//
//  StoreList.swift
//  food_recommend
//
//  Created by 김세연 on 2021/06/19.
//
import Combine
import SwiftUI

class StoreList : ObservableObject {
    @Published var stores: [Store]
    
    init(stores: [Store] = []){
        self.stores = stores
    }
}
