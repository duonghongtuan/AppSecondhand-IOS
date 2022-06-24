//
//  ImagesProductView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/28/22.
//

import SwiftUI

struct ImagesProductView: View {
    @StateObject var imageViewModel = ImageViewModel()
    @EnvironmentObject var viewModel : PostViewModel
    func didSelectImage(_ image: UIImage?) {
        imageViewModel.didSelectImage(image)
        if let image = image{
            viewModel.addImage(image: image)
        }
    }
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal){
                if let images = viewModel.images{
                    HStack {
                        ForEach(images, id: \.self){ image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                            .frame(height: 250)
                        }
                    }
                }
            }
            Button(action: {
                imageViewModel.showActionSheet.toggle()
            }, label: {
                Text("Thêm ảnh")
                    .foregroundColor(.white)
            })
            .padding(.vertical, 4.0)
            .padding(.horizontal)
            .background(.blue)
            .cornerRadius(8)
        }
        .fullScreenCover(isPresented: $imageViewModel.isPresentingImagePicker, content: {
            
            ImagePicker(sourceType: imageViewModel.sourceType, completionHandler: didSelectImage)
            
        })
        .actionSheet(isPresented: $imageViewModel.showActionSheet) {
            imageViewModel.actionSheetView()

        }
    }
}

struct ImagesProductView_Previews: PreviewProvider {
    static var previews: some View {
        ImagesProductView()
    }
}
