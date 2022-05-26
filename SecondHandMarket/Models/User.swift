//
//  User.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/19/22.
//

import Foundation

struct User: Hashable, Codable, Identifiable{
    var id: String = "UUID()"
    var name: String
    var email: String
    var phoneNumber: String
    var address: String
    var avatar: String
    var productIds: [String]
    
}
