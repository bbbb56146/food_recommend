//
//  foodDetailView.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/31.
//
import SwiftUI
import WebKit

struct foodDetailView: View {
    @State var isTapped = false
    @State var tappedStoreName = ""
    let selectedFood: String
    @State var stores = [StoreInfo]()
    @State var doubleTapped = false;
    @State var webUrl = ""
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
                               // HStack{
                                    Text(store.place_name).font(.title).fontWeight(.semibold).multilineTextAlignment(.leading)
                                 //   Spacer()
                                    
                                //}
                                Text(store.road_address_name).font(.body).fontWeight(.thin).multilineTextAlignment(.leading).lineLimit(3)
                                Text("\(store.distance) M")
                                    .multilineTextAlignment(.trailing)
                                
                            }//Vstack end
                            
                            .onTapGesture{
                                webUrl = store.place_url;
                                isTapped = true;
                                print("tapped \(store.place_name)")
                                tappedStoreName = store.place_name
                                doubleTapped = true;
                                print(webUrl)
                            }
                            .padding()
                            .frame(height: 130)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9803921569, green: 0.6470588235, blue: 0.3764705882, alpha: 1)), Color(#colorLiteral(red: 0.9882352941, green: 0.6705882353, blue: 0.6039215686, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(15.0)
                        }//for each end
                       // .onAppear(perform: loadData)
                    }//hstack end
                }
                .onAppear(perform: loadData)
                .sheet(isPresented: $doubleTapped){
                    MyWebView(urlToLoad: webUrl)
                }

            }
        }
    }//end of body
    func loadData(){
        print(selectedFood)
        let str = IP+"/detail/"+self.selectedFood
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
                  let result = try decoder.decode(RecoMenu.self, from: data)
                    print(result)
                    print("SUCCESS")
                    DispatchQueue.main.async {
                        self.stores = result.documents
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
}

struct foodDetailView_Previews: PreviewProvider {

    static var previews: some View {
        foodDetailView(selectedFood: "떡")
    }
}
