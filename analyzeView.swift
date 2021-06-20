//
//  analyzeView.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/31.
//

import SwiftUI
import PhotosUI

struct analyzeView: View {
    @State private var isPresented: Bool = false
    @State private var isAleart: Bool = false
    @State var pickerResult: [UIImage] = []
    var config: PHPickerConfiguration  {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images //videos, livePhotos...
        config.selectionLimit = 0 //0 => any, set 1-2-3 for har limit
        return config
    }
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
            Text("4단계로 사진 올리기!")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.vertical)
                .multilineTextAlignment(.center)
            Group{
                //Text("")
                Text("1. present picker 버튼을 누르세요.")
                Text("2. search bar에 '음식' 검색")
                Text("3. 손가락을 drag해 여러 사진을 선택할 수 있어요!")
                Text("4. 분석하기 버튼을 누르세요.")
                Text("")
            }
            //.padding(.bottom)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9803921569, green: 0.6470588235, blue: 0.3764705882, alpha: 1)), Color(#colorLiteral(red: 0.9882352941, green: 0.6705882353, blue: 0.6039215686, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    //.padding(.top)
            )
            .foregroundColor(.white)
            .cornerRadius(25.0, corners:[.bottomLeft, .bottomRight])
            .edgesIgnoringSafeArea(.top)
            Spacer()
            
            Button("Present Picker") {
                isPresented.toggle()
            }.sheet(isPresented: $isPresented) {
                PhotoPicker(configuration: self.config, pickerResult: $pickerResult, isPresented: $isPresented)
            }
            .padding()
            .font(.title)
            .frame(maxWidth:.infinity, minHeight: 120,alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/ )
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9803921569, green: 0.6470588235, blue: 0.3764705882, alpha: 1)), Color(#colorLiteral(red: 0.9882352941, green: 0.6705882353, blue: 0.6039215686, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    //.padding(.top)
            )
            .foregroundColor(.white)
            .cornerRadius(25.0)
            .ignoresSafeArea()
            
            Spacer()
            
            Button("분석하기") {
                isAleart.toggle()
            }.alert(isPresented: self.$isAleart){
                Alert(title: Text("분석 중.."), message: Text("열심히 분석하고 있어요!"), dismissButton: .default(Text("취소")))
            }
            .font(.title)
            .padding()
            .frame(maxWidth:.infinity, minHeight: 120,alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/ )
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9803921569, green: 0.6470588235, blue: 0.3764705882, alpha: 0.8254342995)), Color(#colorLiteral(red: 0.9764705882, green: 0.7450980392, blue: 0.1568627451, alpha: 0.6900230559))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    //.padding(.top)
            )
            .foregroundColor(.white)
            .cornerRadius(25.0)
            Spacer()
            //이미지 결과 (pickerResult) 가지고 분석 돌리기
            
            //분석한 결과 json으로 바꾸기
            
            //결과 : userMenuData.json
        }
        .edgesIgnoringSafeArea(.top)
    }

}
struct PhotoPicker: UIViewControllerRepresentable {
    let configuration: PHPickerConfiguration
    @Binding var pickerResult: [UIImage]
    @Binding var isPresented: Bool
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    /// PHPickerViewControllerDelegate => Coordinator
    class Coordinator: PHPickerViewControllerDelegate {
        
        private let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            for image in results {
                if image.itemProvider.canLoadObject(ofClass: UIImage.self)  {
                    image.itemProvider.loadObject(ofClass: UIImage.self) { (newImage, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            self.parent.pickerResult.append(newImage as! UIImage)
                        }
                    }
                } else {
                    print("Loaded Assest is not a Image")
                }
            }
            // dissmiss the picker
            parent.isPresented = false
        }
    }
}
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


struct analyzeView_Previews: PreviewProvider {
    static var previews: some View {
        analyzeView()
    }
}
