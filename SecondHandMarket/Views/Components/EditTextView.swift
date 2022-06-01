//
//  EditTextView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/28/22.
//

import SwiftUI

struct EditTextView: View {
    var lable: String
    var placeholder: String = ""
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(lable)")
            TextField(placeholder,text: $text)
                .padding(6.0)
                .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.green, lineWidth: 1)
                    )
            
        }
        
    }
}

struct EditTextView_Previews: PreviewProvider {
    static var previews: some View {
        EditTextView(lable: "ten san pham", text: .constant(""))
    }
}
