//
//  foodDetailView.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/31.
//

import SwiftUI

struct foodDetailView: View {
    let selectedFood: FoodList
    var body: some View {
        VStack {
            //맵뷰
            
            //가게 리스트
            let storeLists = filter(foodname: self.selectedFood.name)
            List(storeLists, id: \.id){ store in
                VStack(alignment: .leading){
                    HStack{
                        Text(store.name).font(.title).fontWeight(.semibold).multilineTextAlignment(.leading)
                        Spacer()
                        Text("\(store.len) M")
                            .multilineTextAlignment(.trailing)
                    }
                    Text(store.addr).font(.body).fontWeight(.thin).multilineTextAlignment(.leading).lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    
                }
            }
        }
    }
}
func filter(foodname: String) -> [StoreList]{
    var filteredList = [StoreList]()
    let data = StoreList.all()
    for store in data {
        if store.food == foodname {
            filteredList.append(store)
        }
    }
    return filteredList
}
struct foodDetailView_Previews: PreviewProvider {
    static let previewFoodList = FoodList(name: "피자", imageUrl: "plate-2802332_640", totalNum: 22)
    static var previews: some View {
        foodDetailView(selectedFood: previewFoodList)
    }
}
