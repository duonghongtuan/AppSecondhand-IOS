//
//  RegisterViewModel.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/20/22.
//

import Foundation
import SwiftUI

class ImageViewModel: ObservableObject{
    @Published var selectedImage: UIImage?
    @Published var isPresentingImagePicker = false
    @Published var showActionSheet = false
    private(set) var sourceType: ImagePicker.SourceType = .camera
    @Published var images = [UIImage]()
    
    
    
    func actionSheetView() -> ActionSheet{
        let actionSheet : ActionSheet = ActionSheet(
            title: Text("Chọn ảnh"),
            buttons: [
                .default(Text("Chọn từ thư viện")) {
                    self.choosePhoto()
                },

                .default(Text("Chụp ảnh")) {
                    self.takePhoto()
                },
                .cancel(Text("Huỷ"))

            ]
        )
        return actionSheet
        
    }
    
    
    func choosePhoto() {
        sourceType = .photoLibrary
        isPresentingImagePicker = true
    }
    
    func takePhoto() {
        sourceType = .camera
        isPresentingImagePicker = true
    }
    
    func didSelectImage(_ image: UIImage?) {
        selectedImage = image
        if let image = image{
            images.append(image)
        }
        isPresentingImagePicker = false
    }
}
