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
        @State var pickerResult: [UIImage] = []
        var config: PHPickerConfiguration  {
           var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
            config.filter = .images //videos, livePhotos...
            config.selectionLimit = 0 //0 => any, set 1-2-3 for har limit
            return config
        }
        
        var body: some View {
            ScrollView {
                LazyVStack {
                    Button("Present Picker") {
                        isPresented.toggle()
                    }.sheet(isPresented: $isPresented) {
                        PhotoPicker(configuration: self.config,
                                    pickerResult: $pickerResult,
                                    isPresented: $isPresented)
                    }
                    ForEach(pickerResult, id: \.self) { image in
                        Image.init(uiImage: image)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width, height: 250, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                    }
                }
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
