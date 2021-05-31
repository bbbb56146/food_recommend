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
                       // var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
                       // configuration.selectionLimit=0
                        //configuration.filter = .images
                        PhotoPicker(isPresented: $isPresented)
                    }
        }
    }
}
struct PhotoPicker: UIViewControllerRepresentable {
        
    typealias UIViewControllerType = PHPickerViewController
    @Binding var isPresented: Bool
    var itemProviders: [NSItemProvider] = []
    var images: [UIImage] = []
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .any(of: [.images, .livePhotos])
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
            return PhotoPicker.Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate, UINavigationControllerDelegate {
            
            var parent: PhotoPicker
            
            init(parent: PhotoPicker) {
                    self.parent = parent
            }
            
            func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
                    picker.dismiss(animated: true)
                    if !results.isEmpty {
                            parent.itemProviders = []
                            parent.images = []
                    }
                    
                    parent.itemProviders = results.map(\.itemProvider)
                    loadImage()
            }
            
            private func loadImage() {
                    for itemProvider in parent.itemProviders {
                            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                                    itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                                            if let image = image as? UIImage {
                                                    self.parent.images.append(image)
                                            } else {
                                                    print("Could not load image", error?.localizedDescription ?? "")
                                            }
                                    }
                            }
                    }
            }
    }
}
struct analyzeView_Previews: PreviewProvider {
    static var previews: some View {
        analyzeView()
    }
}
