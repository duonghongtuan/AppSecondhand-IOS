//
//  Authentication.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/17/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class Authentication{
    let firebaseAuth = Auth.auth()
    let db = Firestore.firestore()
    
    func login(email: String, password: String, completion: @escaping (User) -> Void){
        firebaseAuth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            if let uid = authResult?.user.uid{
                self!.getUser(id: uid){ user in
                    completion(user)
                    
                }
            }
            
        }
    }
    
    func getUser(id: String,completion: @escaping (User) -> Void){
        let usersRef = db.collection("users")
        let user = usersRef.whereField("id", isEqualTo: id)
        user.getDocuments(){
            (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        
                        for document in querySnapshot!.documents {
                            let data = document.data()
                            let user = User(id: data["id"] as! String, name: data["name"] as! String, email: data["email"] as! String, phoneNumber: data["phoneNumber"] as! String, address: data["address"] as! String, avatar: data["avatar"] as! String, productIds: data["productIds"] as! [String])
                            completion(user)
                        }
                    }
            
        }
        
    }
    
    func register(password: String,user: User, completion: @escaping (Bool) -> Void){
        firebaseAuth.createUser(withEmail: user.email, password: password) { authResult, error in
            if let error = error{
                print(error)
            }else{
                if let uid = authResult?.user.uid{
                    self.addUser(user: user, id: uid){ result in
                        if result == true{
                            completion(true)
                        }else{
                            completion(false)
                        }
                    }
                    
                }
            }
        }
    }
    
    func addUser(user: User, id : String, completion: @escaping (Bool) -> Void){
        let data: [String: Any]=[
            "id": id,
            "name": user.name,
            "email": user.email,
            "phoneNumber": user.phoneNumber,
            "address": user.address,
            "avatar": user.avatar,
            "productIds": user.productIds
            
        ]
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: data) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(false)
            } else {
                print("Document added with ID: \(ref!.documentID)")
                completion(true)
            }
        }
    }
    
    func logOut(){
        do {
          try firebaseAuth.signOut()
            print("logout")
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
