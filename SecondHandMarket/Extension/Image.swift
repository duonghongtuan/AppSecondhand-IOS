//
//  Image.swift
//  SecondHandMarket
//
//  Created by HongTuan on 07/06/2022.
//

import Foundation
import SwiftUI

extension UIImage {
    var base64: String? {
        let imgString = self.jpegData(compressionQuality: 0.6)?.base64EncodedString()
        return imgString
    }
}
