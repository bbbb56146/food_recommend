//
//  ContentView.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/30.
//
import SwiftUI

struct ContentView: View {
    @State var isAnalyzeStart: Bool = false
    let foodLists = FoodList.all()

    var body: some View {
        
        VStack(alignment:.leading, spacing: 0){
            Button(action: {
                print("button pressed!")
                self.isAnalyzeStart = true
            }) {
                Text("분석하려면 누르세요..")
            }
            .alert(isPresented: self.$isAnalyzeStart){
                Alert(title: Text("분석 중.."), message: Text("열심히 분석하고 있어요!"), dismissButton: .default(Text("취소")))
            }
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
        }
       
    }
    //view end
}
//body end

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
