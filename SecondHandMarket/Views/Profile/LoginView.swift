//
//  LoginIView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/17/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        VStack {
            HStack{
                VStack(alignment: .leading){
                    Text("Tên đăng nhập: ")
                        .padding(2.0)
                    Text("Mật khẩu: ")
                        .padding(2.0)
                    
                }
                VStack(alignment: .leading){
                    TextField("", text: $viewModel.userName)
                        .padding(4.0)
                        .background()
                        .cornerRadius(8)
                    SecureField("",text: $viewModel.password)
                        .padding(4.0)
                        .background()
                        .cornerRadius(8)
                }
            }
            .padding()
            .background(Color.blue3)
            .cornerRadius(12)
            
            
            Button(action: {
                viewModel.login(context: viewContext, mode: mode)
            }, label: {
                    Text("Đăng nhập")
                    .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                        
            })
            .padding()
            .background(.blue)
            .cornerRadius(16)

            
        }
        .popup(isPresented: $viewModel.showPopUp, animation: .default,dragToDismiss: false, closeOnTap: false){
            VStack{
                ActivityIndicator(isAnimating: $viewModel.load, style: .large)
                    .padding()
                    .background(Color.green1)
                    .cornerRadius(8)
            }
            .frame(width: Screen.width, height: Screen.height)
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
