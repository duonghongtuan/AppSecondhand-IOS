//
//  product.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/20/22.
//

import Foundation

//protocol Product{
//    var id: String { get }
//    var categoryId: String {get}
//    var name: String {get set}
//    var company: String {get set}
//    var status: String {get set}
//    var createDate: Double {get}
//    var lastUpdate: Double {get set}
//    var images: [String] {get set}
//    var price: Int {get set}
//    var total: Int {get set}
//    var description: String {get set}
//}

class Object{
    func convertObjectToArrayStringAny()-> [String: Any]{
        let mirror = Mirror(reflecting: self)
        var array = [String: Any]()
        
        for child in mirror.children{
            array[child.label!] = child.value
        }
        return array
    }
}

class Product:Object,Identifiable{
    
    var id: String = ""
    
    var categoryId: String = ""
    
    var name: String = ""
    
    var company: String  = ""
    
    var status: String = ""
    
    var createDate: Int64 = 0
    
    var lastUpdate: Int64 = 0
    
    var images: [String] = []
    
    var price: String = ""
    
    var total: String = ""
    
    var description: String = ""
    
    var ram: String = ""
    var screen: String = ""
    var hardDrive: String = ""
    var memory: String = ""
    var color: String = ""
}
