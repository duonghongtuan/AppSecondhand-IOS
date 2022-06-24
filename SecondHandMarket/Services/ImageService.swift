//
//  imageService.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/23/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

//func convertImageToBase64String (img: UIImage) -> String {
//    return img.jpegData(compressionQuality: 0.2)?.base64EncodedString() ?? ""
//}

func convertBase64StringToImage (imageBase64String:String,completion: @escaping (UIImage) -> Void){
    DispatchQueue.main.async {
        guard let imageData = Data(base64Encoded: imageBase64String, options: .ignoreUnknownCharacters) else {
            print("Error: couldn't create UIImage")
            return
        }
        guard let image = UIImage(data: imageData) else{return}
        completion(image)
    }
}

class ImageService{
    let storage = Storage.storage()
    let storageRef = Storage.storage().reference()
    
    func upLoadImage(image: UIImage, completion: @escaping (String) -> Void){
        let storageRef = storage.reference()
        
        let imageData = image.jpegData(compressionQuality: 0.5)
        
        let ImagesRef = storageRef.child("images/\(UUID().uuidString).jpg")
        
        ImagesRef.putData(imageData!){ metaDate, error in
            if metaDate != nil && error == nil{
                if let error = error{
                    print(error)
                }else{
                    if let name = metaDate?.name{
                        completion(name)
                    }
                }
            }
        }
    }
    
    func downLoadImage(url: String, completion: @escaping (UIImage) -> Void){
        let islandRef = storageRef.child(url)
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
              print(error)
          } else {
            // Data for "images/island.jpg" is returned
              if let image = UIImage(data: data!){
                  completion(image)
              }
          }
        }
    }
}
