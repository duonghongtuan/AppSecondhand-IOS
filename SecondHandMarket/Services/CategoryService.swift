//
//  CategoryService.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/26/22.
//

import Foundation
import FirebaseFirestore

class CategoryService{
    let db = Firestore.firestore()
    
    func getCategories(completion: @escaping ([Category])->Void){
        let categoriesRef = db.collection("category")
        categoriesRef.getDocuments(){
            (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        var array : [Category] = []
                        for document in querySnapshot!.documents {
                            let data = document.data()
                            let category = Category(id: data["id"] as! String,name: data["name"] as! String, companies: data["companies"] as! [String])
                            array.append(category)
                        }
                        completion(array)
                    }
            
        }
    }
}
