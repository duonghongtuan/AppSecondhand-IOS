//
//  User.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/19/22.
//

import Foundation

struct User: Object{
    var id: String = "\(UUID())"
    var name: String
    var email: String
    var phoneNumber: String
    var address: String
    var avatar: String
    var productIds: [String]
    var cartIds: [String]
    var orderIds: [String]
    var follows: [String]
}
