//
//  Screen.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/23/22.
//

import SwiftUI

struct Screen {
    static var width: CGFloat {  return UIScreen.main.bounds.width }
    static var height: CGFloat {  return UIScreen.main.bounds.height }
    static var statusBarHeight: CGFloat {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let viewController = window!.rootViewController
        return viewController!.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
    }
}
