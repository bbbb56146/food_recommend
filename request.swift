//
//  GetJSON.swift
//  food_recommend
//
//  Created by 김세연 on 2021/06/20.
//
import UIKit
//import SwiftUI
import Combine

import SwiftUI
import Combine
struct InfoReco : Codable{
    var name:String
    var num: Int
    var similarity: Double
}
struct StoreInfo: Codable, Identifiable{
    var address_name: String
    var category_group_code: String
    var category_group_name: String
    var category_name: String
    var distance: Int
    var id: String
    var phone: String
    var place_name : String
    var place_url: String
    var load_address_name: String
    var x: Double
    var y: Double
}
struct SameNameMenu: Codable{
    var keyword : String
    var region : [String]
    var selected_region : String
}
struct Meta : Codable{
    var is_end: Bool
    var pageable_count: Int
    var same_name : SameNameMenu
    var total_count : Int
}
struct RecoMenu : Codable{
    var menuName : String
    var document: [StoreInfo]
    var meta : Meta
}
struct Response: Codable {
    var info : [InfoReco]
    var data: [RecoMenu]
}

public var query = """
/reco?food_freq={"닭갈비": 6, "오일파스타": 8, "김밥": 3, "된장찌개": 5, "쌀국수": 2}&user_feedback={"닭갈비": 4, "김밥": 13, "떡볶이": 7}
"""
public var IP = "http://52.79.168.220:5000"




//func loadData<Response: Decodable>(_ query: String) -> Response{
//    if let url = URL(string: query) {
//      var request = URLRequest.init(url: url)
//
//      request.httpMethod = "GET"
//
//      URLSession.shared.dataTask(with: request) { (data, response, error) in
//        guard let data = data else { fatalError("could not load JSON DATA") }
//
//        // data
//        do{
//            return try JSONDecoder().decode(Response.self, from: data)
//        } catch{
//            fatalError("parse unable")
//        }
//      }.resume()
//    }
//    else{
//        fatalError("make URL failed")
//    }
//    fatalError("Unknown Err")
//}

//    if let url = URL(string: query){
//        var request = URLRequest.init(url: url)
//        request.httpMethod = "GET"
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            guard let data = data else { return }
//            // data
//            let result = try? JSONDecoder().decode(Response.self, from: data)
//            if let result = result {
//                print(result)
//                return result
//            }
//            else{
//                fatalError("Unable to parse")
//            }
////            let decoder = JSONDecoder()
////            if let json = try? decoder.decode(Response.self, from: data) {
////                  print(json) // hyeon
////            }
//        }.resume()
//    }
//    else{
//        fatalError("Invalid URL")
//    }




//    //url
//    guard let url = URL(string: "http://52.79.168.220:5000//method?food_freq={%22%EB%8B%AD%EA%B0%88%EB%B9%84%22:%206,%20%22%EC%98%A4%EC%9D%BC%ED%8C%8C%EC%8A%A4%ED%83%80%22:%208,%20%22%EA%B9%80%EB%B0%A5%22:%203,%20%22%EB%90%9C%EC%9E%A5%EC%B0%8C%EA%B0%9C%22:%205,%20%22%EC%8C%80%EA%B5%AD%EC%88%98%22:%202}&user_feedback={%22%EB%8B%AD%EA%B0%88%EB%B9%84%22:%204,%20%22%EA%B9%80%EB%B0%A5%22:%2013,%20%22%EB%96%A1%EB%B3%B6%EC%9D%B4%22:%207}") else {
//        fatalError("Invalid URL")
//    }
//
//    //get
//    URLSession.shared.dataTask(with: url) { data, response, error in
//        guard let data = data, error == nil else {
//            return
//        }
//
//        let result = try? JSONDecoder().decode(Response.self, from: data)
//        if let result = result {
//            print(result)
//        }
//
//
//    }.resume()
