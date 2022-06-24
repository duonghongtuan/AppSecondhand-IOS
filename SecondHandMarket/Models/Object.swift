//
//  Object.swift
//  SecondHandMarket
//
//  Created by HongTuan on 05/06/2022.
//

import Foundation

protocol Object: Codable, Identifiable{
    var id: String {get set}
}
extension Object{
    func convertObjectToArrayStringAny()-> [String: Any]{
        let mirror = Mirror(reflecting: self)
        var array = [String: Any]()
        
        for child in mirror.children{
            array[child.label!] = child.value
        }
        return array
    }
}
