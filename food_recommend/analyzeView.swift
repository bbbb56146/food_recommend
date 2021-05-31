//
//  analyzeView.swift
//  food_recommend
//
//  Created by 김세연 on 2021/05/31.
//

import SwiftUI
import PhotosUI

struct analyzeView: View {
    @State var isAnalyzeStart: Bool = false
    @State private var isPresented: Bool = false
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
            Button("Present Picker") {
                        isPresented.toggle()
                    }.sheet(isPresented: $isPresented) {
                        let configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
                        PhotoPicker(configuration: configuration, isPresented: $isPresented)
                    }
        }
    }
}
struct PhotoPicker: UIViewControllerRepresentable {
    let configuration: PHPickerConfiguration
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
    
    // Use a Coordinator to act as your PHPickerViewControllerDelegate
    class Coordinator: PHPickerViewControllerDelegate {
      
        private let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            print(results)
            parent.isPresented = false // Set isPresented to false because picking has finished.
        }
    }
}
struct analyzeView_Previews: PreviewProvider {
    static var previews: some View {
        analyzeView()
    }
}
