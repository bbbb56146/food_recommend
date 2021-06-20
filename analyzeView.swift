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
        VStack(alignment: .leading){
            Text("4단계로 사진 올리기!")
                .font(.largeTitle).bold()
            Group{
            Text("1. present picker 버튼을 누르세요.")
            Text("2. search bar에 '음식' 검색")
            Text("3. 손가락을 드래그 해 여러 사진을 선택할 수 있어요!")
            Text("4. 분석하기 버튼을 누르세요.")
            }
            Button("Present Picker") {
                isPresented.toggle()
            }.sheet(isPresented: $isPresented) {
                PhotoPicker(configuration: self.config, pickerResult: $pickerResult, isPresented: $isPresented)
            }
            Button("분석하기") {
                isAleart.toggle()
            }.alert(isPresented: self.$isAleart){
                Alert(title: Text("분석 중.."), message: Text("열심히 분석하고 있어요!"), dismissButton: .default(Text("취소")))
            }
            //이미지 결과 (pickerResult) 가지고 분석 돌리기
            
            //분석한 결과 json으로 바꾸기
            
            //결과 : userMenuData.json
        }
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
struct analyzeView_Previews: PreviewProvider {
    static var previews: some View {
        analyzeView()
    }
}
