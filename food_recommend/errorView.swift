//
//  errorView.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/31.
//

import SwiftUI

struct errorView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("에러가 발생했습니다 ㅠ")
                .font(.largeTitle)
                .fontWeight(.black)
                .multilineTextAlignment(.leading)
            //Spacer()
            Button(action: {
                print("goto main!")
                //ContentView()
            }) {
                Text("메인 화면으로 돌아가기")
            }
        }
    }
}

struct errorView_Previews: PreviewProvider {
    static var previews: some View {
        errorView()
    }
}
