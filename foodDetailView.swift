//
//  foodDetailView.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/31.
//
import SwiftUI

struct foodDetailView: View {
    @State var isTapped = false
    @State var tappedStoreName = ""
    let selectedFood: FoodList
    var body: some View {
        ZStack {
            //맵뷰
            MapView(isTapped: $isTapped, tappedStoreName: $tappedStoreName, stores: filter(foodname: self.selectedFood.name))
            //MapView()
            //가게 리스트
            VStack{
                Spacer()
                let stores = filter(foodname: self.selectedFood.name)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(alignment: .bottom){
                        ForEach(stores, id: \.id){ store in
                            VStack(alignment: .leading) {
                                HStack{
                                    Text(store.name).font(.title).fontWeight(.semibold).multilineTextAlignment(.leading)
                                    Spacer()
                                    Text("\(store.len) M")
                                        .multilineTextAlignment(.trailing)
                                }
                                Text(store.addr).font(.body).fontWeight(.thin).multilineTextAlignment(.leading).lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                
                            }//Vstack end
                            .onTapGesture{
                                isTapped = true;
                                print("tapped \(store.name)")
                                tappedStoreName = store.name
                                
                            }
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
func filter(foodname: String) -> [Store]{
    var filteredList = [Store]()
    @ObservedObject var storeList: StoreList = StoreList(stores: storeData)
    for store in storeList.stores {
        if store.food == foodname {
            filteredList.append(store)
        }
    }
    return filteredList
}

struct foodDetailView_Previews: PreviewProvider {
    static let previewFoodList = FoodList(id: "2", name: "피자", imageUrl: "plate-2802332_640", totalNum: 22)
    static var previews: some View {
        foodDetailView(selectedFood: previewFoodList)
    }
}
