//
//  todayRecommendView.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/31.
//

import SwiftUI

struct todayRecommendView: View {
   
    let foodLists = FoodList.all()

    var body: some View {
        NavigationView {
            List(self.foodLists, id: \.name) { foodList in
                NavigationLink(destination: foodDetailView(selectedFood: foodList)){
                    FoodListCell(foodList: foodList)
                }
            }
            .navigationBarTitle(Text("오늘의 메뉴"))
            .navigationBarHidden(false)
            
        }
        
        //navigation end
        
    }//body end
}//view end

//Cell은 별도의 파일로 분리하셔도 상관없습니다.
struct FoodListCell: View {

    let foodList: FoodList

    var body: some View {
        HStack {
            Image(foodList.imageUrl)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(16)

            VStack(alignment: .leading) {
                Text(foodList.name).font(.title).fontWeight(.semibold)
                Text("\(foodList.totalNum) 가게")
            }
        }
    }
}

struct todayRecommendView_Previews: PreviewProvider {
    static var previews: some View {
        todayRecommendView()
    }
}
