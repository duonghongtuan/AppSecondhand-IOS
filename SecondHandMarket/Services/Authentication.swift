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
        
        let docRef = db.collection("users").document(id)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists{
                let decoder = JSONDecoder()
                let arrayObject = document.data()
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: arrayObject as Any, options: [])
                    let object = try decoder.decode(User.self, from: jsonData)
                    completion(object)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print("Document does not exist")
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
        var objUser = user
        objUser.id = id
        let data = objUser.convertObjectToArrayStringAny()
        
        db.collection("users").document(id).setData(data) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(false)
            } else {
                print("Document added with ID: \(id)")
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
