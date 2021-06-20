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
    let selectedFood: String
    @State var stores = [StoreInfo]()
    var body: some View {
        ZStack {
            //맵뷰
            MapView(isTapped: $isTapped, tappedStoreName: $tappedStoreName, stores: $stores)
            //MapView()
            //가게 리스트
            VStack{
                Spacer()
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(alignment: .bottom){
                        ForEach(stores, id: \.id){ store in
                            VStack(alignment: .leading) {
                                HStack{
                                    Text(store.place_name).font(.title).fontWeight(.semibold).multilineTextAlignment(.leading)
                                    Spacer()
                                    Text("\(store.distance) M")
                                        .multilineTextAlignment(.trailing)
                                }
                                Text(store.load_address_name).font(.body).fontWeight(.thin).multilineTextAlignment(.leading).lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                
                            }//Vstack end
                            .onTapGesture{
                                isTapped = true;
                                print("tapped \(store.place_name)")
                                tappedStoreName = store.place_name
                                
                            }
                            .padding()
                            .frame(height: 150)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)), Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .foregroundColor(.black)
                            .cornerRadius(15.0)
                        }//for each end
                        .onAppear(perform: loadData)
                    }//hstack end
                }
            }
        }
    }//end of body
    func loadData(){
        
        if let url = URL(string: IP+"/detail/"+selectedFood) {
            var request = URLRequest.init(url: url)
            request.httpMethod = "GET"

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }

                // data
                let decoder = JSONDecoder()
                if let json = try? decoder.decode(StoreInfo.self, from: data) {
                    print(json) // hyeon
                    //원하는 작업 하기
                    print("===END OF StoreInfo==")
                }
            }.resume()
        }
    }
}

struct foodDetailView_Previews: PreviewProvider {

    static var previews: some View {
        foodDetailView(selectedFood: "떡")
    }
}
