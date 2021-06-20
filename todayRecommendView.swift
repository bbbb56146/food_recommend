//
//  todayRecommendView.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/31.
//

import SwiftUI

struct todayRecommendView: View {
   
    //let foodLists = FoodList.all()
    @State var result = [InfoReco]()
    var body: some View {
        NavigationView {
            List(result, id: \.name) { foodList in
                NavigationLink(destination: foodDetailView(selectedFood: foodList.name)){
                    FoodListCell(foodList: foodList)
                }
            }
            .navigationBarTitle(Text("오늘의 메뉴"))
            .navigationBarHidden(false)
            .onAppear(perform: loadData)
        }
        
        //navigation end
        
    }//body end
    func loadData(){
        let sub = query
        
        if let url = URL(string: IP+sub) {
            var request = URLRequest.init(url: url)
            request.httpMethod = "GET"

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }

                // data
                let decoder = JSONDecoder()
                if let json = try? decoder.decode(InfoReco.self, from: data) {
                    print(json) // hyeon
                    //원하는 작업 하기
                    print("===END OF INFORECO==")
                }
            }.resume()
        }
    }//loadData End
}//view end

struct FoodListCell: View {

    let foodList: InfoReco

    var body: some View {

            VStack(alignment: .leading) {
                Text(foodList.name).font(.title).fontWeight(.semibold)
                HStack{
                    Text("\(foodList.num) 가게")
                    Spacer()
                    Text("\(foodList.similarity) %")
                }

            }
    }
}

struct todayRecommendView_Previews: PreviewProvider {
    static var previews: some View {
        todayRecommendView()
    }
}
