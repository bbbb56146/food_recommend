//
//  todayRecommendView.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/31.
//

import SwiftUI

struct todayRecommendView: View {
   
    //let foodLists = FoodList.all()
    @State var info = [InfoReco]()
  //  var feedback = [UserMenu]()
    var body: some View {
        NavigationView {
            List(info, id: \.name) { food in
                    //print("in List: "+foodList.name)
                //self.feedback.append(UserMenu(food.name))
                NavigationLink(destination: foodDetailView(selectedFood: food.name)){
                   // print("in View: "+foodList.name)
                    FoodListCell(foodList: food)
//                        .onTapGesture(){
//                            //struct
//
//                        }
                }
            }
            .onAppear(perform: loadData)
            .onDisappear(){
                print("reco view Disappear!")
            }
            .navigationBarTitle(Text("오늘의 메뉴"))
            //.navigationBarHidden(true)
            //.navigationBarColor(UIColor(Color(#colorLiteral(red: 0.9764705882, green: 0.7450980392, blue: 0.1568627451, alpha: 1))))
  
        }
        
        //navigation end
        
    }//body end
//    func makeFeedback(){
//        var name: String
//        feedback.append(UserMenu(name: name))
//        return
//    }
    func loadData(){
        let str = IP+"""
//reco?food_freq={"닭갈비": 6, "오일파스타": 8, "김밥": 3, "된장찌개": 5, "쌀국수": 2}&user_feedback={"닭갈비": 4, "김밥": 13, "떡볶이": 7}
"""
        print("Start load")
        if let encoded = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: encoded) {
            var request = URLRequest.init(url: url)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    print("err at data")
                    return
                    
                }
                print("data start")
                // data
                let decoder = JSONDecoder()
                print("decoder")
                do {
                  let result = try decoder.decode([InfoReco].self, from: data)
                  print(result)
                    print("SUCCESS")
                    DispatchQueue.main.async {
                        self.info = result
                    }
                } catch {
                  print(error)
                }
//                print(String(decoding: data, as:UTF8.self))
//                if let json = try! decoder.decode(InfoReco.self, from: data) {
//                    print(json) // hyeon
//                    //원하는 작업 하기
//                    print("===END OF INFORECO==")
//                }
//                print("can't decode")
            }.resume()
        }
        else{
            print("url fail")
        }
    }//loadData End
}//view end

struct FoodListCell: View {

    let foodList: InfoReco

    var body: some View {

        VStack (alignment: .leading){
                Text(foodList.name).font(.title)
                //HStack{
               //     Text("\(foodList.num) 가게")
               //     Spacer()
                Text(String(format:"%.4f"+"%% matched",foodList.similarity*100))
                    .font(.caption)
               // }

            }
    }
}

struct todayRecommendView_Previews: PreviewProvider {
    static var previews: some View {
        todayRecommendView()
    }
}
