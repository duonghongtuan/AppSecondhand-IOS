//
//  String.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/20/22.
//

import Foundation
import SwiftUI

extension String {
    
    var imageFromBase64: UIImage? {
        guard let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            print("Error: couldn't create UIImage")
            return nil
        }
        return UIImage(data: imageData)
    }

    var isValidEmail: Bool {
        let name = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let domain = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        let emailRegEx = name + "@" + domain + "[A-Za-z]{2,8}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: self)
    }

    var numberToMoney: String{
        var string = ""
        var index = 0
        let numberString = String(self.reversed())
        for i in numberString{
            index += 1
            string.append(i)
            if index % 3 == 0 && index != self.count{
                string.append(".")
            }
            
        }
        string = String(string.reversed())
        return string
    }
}
