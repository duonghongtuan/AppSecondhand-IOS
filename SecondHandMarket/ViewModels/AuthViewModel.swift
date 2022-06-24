//
//  LoginViewModel.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/17/22.
//

import Foundation
import SwiftUI
import CoreData

class AuthViewModel: ObservableObject{
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var isAccount : Bool = true
    @Published var user: User
    let auth : Authentication
    let service: Service
    @Published var avatar: UIImage?
    @Published var load = false
    @Published var showPopUp = false
    
    init(service: Service = Service()){
        self.service = service
        self.auth = service.auth()
        user = User(name: "", email: "", phoneNumber: "", address: "", avatar: "", productIds: [], cartIds: [],orderIds: [], follows: [])
    }
    
    func createUserCD(context:NSManagedObjectContext, user: User){
        let userCd = UserCoreData(context: context)
        userCd.name = user.name
        userCd.id = user.id
        userCd.avatar = user.avatar
        userCd.phoneNumber = user.phoneNumber
        userCd.address = user.avatar
        
        save(context: context)
    }
    
    func save(context:NSManagedObjectContext){
            do{
                try context.save()
                print("save thanh cong")
            }
            catch{
                print("error save:",error)
            }
        }
    
    func login(context:NSManagedObjectContext, mode: Binding<PresentationMode>){
        showPopUp = true
        load = true
        auth.login(email: userName, password: password){ [self] user in
            createUserCD(context: context, user: user)
            load = false
            mode.wrappedValue.dismiss()
            showPopUp = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            load = false
            showPopUp = false
        }
    }
    
    func reigister(image: UIImage?, context: NSManagedObjectContext){
        showPopUp = true
        load = true
//        let imageService = service.imageService()
        if let image = image {
//            let imageString = convertImageToBase64String(img: image)
            user.avatar = image.base64!
            auth.register(password: password, user: user){ [self] result in
                if result == true{
                    load = false
                    createUserCD(context: context, user: user)
                }
            }
            
//            imageService.upLoadImage(image: image){ [self] nameImage in
//                print(nameImage)
//                user.avatar = nameImage
//                auth.register(password: password, user: user){ result in
//                    if result == true{
//                        self.load = false
//                        self.createUserCD(context: context, user: self.user)
//                    }
//                }
//            }
        }else{
            auth.register(password: password, user: user){ result in
                if result == true{
                    self.load = false
                    self.createUserCD(context: context, user: self.user)
                }
            }
        }
    }
    
    func logOut(user: UserCoreData, context:NSManagedObjectContext){
        auth.logOut()
        context.delete(user)
        save(context: context)
    }
    
    func imageAvatar(url: String){
        if url != "" {
            convertBase64StringToImage(imageBase64String: url){ image in
                self.avatar = image
            }
//            avatar = url.imageFromBase64
        }

//        service.imageService().downLoadImage(url:"images/\(url)" ){ [self]
//            image in
//            avatar = image
//        }
    }
}
