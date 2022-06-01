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
    var body: some View {
        
        VStack(alignment: .leading) {
            ScrollView(.horizontal){
                if let images = imageViewModel.images{
                    HStack {
                        ForEach(images, id: \.self){ image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                            .frame(width: Screen.width*3/4, height: 250)
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
            ImagePicker(sourceType: imageViewModel.sourceType, completionHandler: imageViewModel.didSelectImage)
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
