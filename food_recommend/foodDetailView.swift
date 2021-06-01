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
        ZStack {
            //맵뷰
            //MapView()
            //가게 리스트
            VStack{
                Spacer()
                let storeLists = filter(foodname: self.selectedFood.name)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(alignment: .bottom){
                        ForEach(storeLists, id: \.id){ store in
                            VStack(alignment: .leading) {
                                HStack{
                                    Text(store.name).font(.title).fontWeight(.semibold).multilineTextAlignment(.leading)
                                    Spacer()
                                    Text("\(store.len) M")
                                        .multilineTextAlignment(.trailing)
                                }
                                Text(store.addr).font(.body).fontWeight(.thin).multilineTextAlignment(.leading).lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                
                            }//Vstack end
                            .padding()
                            .frame(height: 150)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)), Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .foregroundColor(.black)
                            .cornerRadius(15.0)
                        }//for each end
                    }//hstack end
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
