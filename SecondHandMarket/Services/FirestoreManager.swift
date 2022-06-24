//
//  FirestoreManager.swift
//  SecondHandMarket
//
//  Created by HongTuan on 05/06/2022.
//

import Foundation
import FirebaseFirestore

protocol FireStoreProtocol{
    associatedtype Entity
    
    func save(entity: Entity, completion: @escaping (Bool) -> Void)
    
    func getAll(completion: @escaping ([Entity])-> Void)
    
    func getDocumentWithId(id: String, completion: @escaping (Entity)-> Void)
    
    func queryIsEqualTo(id: String, field: String, completion: @escaping ([Entity]) -> Void)
    
    func delete(id: String, completion: @escaping (Bool) -> Void )
    
    func update(entity: Entity, completion: @escaping (Bool) -> Void)
    
}

enum Collection: String{
    case users = "users"
    case posts = "posts"
    case categories = "category"
    case carts = "carts"
    case order = "order"
}

class FireStoreService<T: Object>: FireStoreProtocol{
    typealias Entity = T
    private let collection : String
    let db = Firestore.firestore()
    
    init(collection: Collection){
        self.collection = collection.rawValue
    }
    
    func getAll(completion: @escaping ([T]) -> Void) {
        db.collection(collection).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var array : [T] = []
                for document in querySnapshot!.documents {
                    let arrayObject = document.data()
                    let decoder = JSONDecoder()

                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
                        let object = try decoder.decode(T.self, from: jsonData)
                        array.append(object)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                completion(array)
            }
        }
    }
    
    func getDocumentWithId(id: String, completion: @escaping (T) -> Void) {
        
        let docRef = db.collection(collection).document(id)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists{

                let decoder = JSONDecoder()
                let arrayObject = document.data()
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: arrayObject as Any, options: [])
                    let object = try decoder.decode(T.self, from: jsonData)
                    completion(object)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func queryIsEqualTo(id: String, field: String, completion: @escaping ([T]) -> Void) {
        db.collection(collection).whereField(field, isEqualTo: id)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var array : [T] = []
                    for document in querySnapshot!.documents {
                        let arrayObject = document.data()
                        let decoder = JSONDecoder()

                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
                            let object = try decoder.decode(T.self, from: jsonData)
                            array.append(object)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    completion(array)
                }
        }
    }
    
    func save(entity: T, completion: @escaping (Bool) -> Void) {
        let data = entity.convertObjectToArrayStringAny()
        
        db.collection(collection).document(entity.id).setData(data) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(false)
            } else {
                completion(true)
                print("Document successfully written!")
            }
        }
    }
    
    func update(entity: T, completion: @escaping (Bool) -> Void) {
        let data = entity.convertObjectToArrayStringAny()
        
        db.collection(collection).document(entity.id).updateData(data) { err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(false)
            } else {
                print("Document successfully updated")
                completion(true)
            }
        }
    }
    
    func delete(id: String, completion: @escaping (Bool) -> Void) {
        db.collection(collection).document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
