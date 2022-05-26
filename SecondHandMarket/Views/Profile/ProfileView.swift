//
//  ProfileView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/14/22.
//

import SwiftUI


struct ProfileView: View {
    @StateObject var viewModel = AuthViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \UserCoreData.id, ascending: true)],
        animation: .default)
    private var users: FetchedResults<UserCoreData>
    
    
    var body: some View {
        if users.isEmpty == false{
            let _ = viewModel.imageAvatar(url: users[0].avatar!)
        }
        VStack{
            if users.isEmpty == false{
                VStack {
                    HStack(alignment: .center) {
                        if let image = viewModel.avatar{
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 80, height: 80)
                                .cornerRadius(40)
                        }else{
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .cornerRadius(40)
                        }
                        
                        
                        VStack(alignment: .leading) {
                            Text(users[0].name!)
                                .foregroundColor(.white)
                            .font(.title3)
                            Text(users[0].phoneNumber!)
                        }
                        Spacer()
                    }
                }
                .padding()
                .background(Color.blue3)
            }
            List(){
                if users.isEmpty{
                    NavigationLink(destination: RegisterView()
                        .environmentObject(viewModel)
                        .environment(\.managedObjectContext, viewContext)
                        .navigationTitle("Đăng ký")
                        .navigationBarTitleDisplayMode(.inline)
                        
                        , label: {
                            Text("Đăng ký tài khoản")
                        })
                    .navigationTitle("Tài khoản")
                    
                    NavigationLink(destination: LoginView()
                        .environmentObject(viewModel)
                        .environment(\.managedObjectContext, viewContext)
                        .navigationTitle("Đăng nhập")
                        .navigationBarTitleDisplayMode(.inline)
                        
                        , label: {
                            Text("Đăng nhập")
                        })
                    .navigationTitle("Tài khoản")
                }else{
                    Text("Đăng xuất")
                        .onTapGesture {
                            viewModel.logOut(user: users[0], context: viewContext)
                        }
                }
                
            }
            .padding(.top, -8.0)
            
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
