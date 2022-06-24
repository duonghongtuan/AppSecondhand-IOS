//
//  ImagesView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 09/06/2022.
//

import SwiftUI

struct ImagesView: View {
    var imageStrings: [String]
    @State var scale: CGFloat = 1
    var body: some View {
        VStack {
            TabView{
                ForEach(imageStrings, id: \.self){imageString in
                    Image(uiImage: imageString.imageFromBase64!)
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .zoomable(scale: $scale)
                }
            }
            .tabViewStyle(.page)
            
            
        }
        .background(.gray)
        
    }
}

struct ImagesView_Previews: PreviewProvider {
    static var previews: some View {
        ImagesView(imageStrings: [])
    }
}
