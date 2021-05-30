//
//  analyzeView.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/31.
//

import SwiftUI

struct analyzeView: View {
    @State var isAnalyzeStart: Bool = false
    var body: some View {
        VStack(alignment: .leading){
            Text("사진을 분석합니다!")
                .font(.largeTitle)
                .fontWeight(.black)
                .multilineTextAlignment(.leading)
            //Spacer()
            Button(action: {
                print("button pressed!")
                self.isAnalyzeStart = true
            }) {
                Text("분석하려면 누르세요..")
            }
            .alert(isPresented: self.$isAnalyzeStart){
                Alert(title: Text("분석 중.."), message: Text("열심히 분석하고 있어요!"), dismissButton: .default(Text("취소")))
            }
        }
    }
}

struct analyzeView_Previews: PreviewProvider {
    static var previews: some View {
        analyzeView()
    }
}
