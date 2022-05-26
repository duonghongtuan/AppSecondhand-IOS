//
//  RegisterView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/20/22.
//

import SwiftUI
import PopupView

struct RegisterView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject var imageViewModel = ImageViewModel()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading){
                    Text("Email:")
                    TextField("email",text: $viewModel.user.email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                    Text("Họ và tên")
                    TextField("Tên", text: $viewModel.user.name)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                    Text("Mật khẩu")
                    SecureField("Mật khẩu", text: $viewModel.password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                    Text("Số điện thoại")
                    TextField("Số điện thoại", text: $viewModel.user.phoneNumber)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                    Text("Địa chỉ")
                    TextField("Địa chỉ", text: $viewModel.user.address)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                }
                
                Text("Ảnh đại diện")
                
                VStack(alignment: .leading) {
                            imageView(for: imageViewModel.selectedImage)
                        }
                        .fullScreenCover(isPresented: $imageViewModel.isPresentingImagePicker, content: {
                            ImagePicker(sourceType: imageViewModel.sourceType, completionHandler: imageViewModel.didSelectImage)
                        })
                Button(action: {
                    viewModel.reigister(image: imageViewModel.selectedImage, context: viewContext)
                },label: {
                    Text("Đăng ký tài khoản")
                        .foregroundColor(.white)
                })
                .padding()
                .background(Color.green)
                .cornerRadius(8)
            }
        }
        .popup(isPresented: $viewModel.showPopUp, animation: .default,dragToDismiss: false, closeOnTap: false){
            VStack{
                if viewModel.load{
                    ActivityIndicator(isAnimating: $viewModel.load, style: .large)
                        .padding()
                        .background(Color.green1)
                        .cornerRadius(8)

                }else{
                    VStack{
                       Text("Bạn đã đăng ký tài khoản thành công")
                            .font(.title3)
                            .padding()
                       Text("Thoát")
                            .padding()
                            .background(Color.green)
                            .cornerRadius(8)
                            .onTapGesture {
                                self.mode.wrappedValue.dismiss()
                                viewModel.showPopUp = false
                            }
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(16)
                    .shadow(radius: 5)
                }
            }
            .frame(width: Screen.width, height: Screen.height)
            
        }
        .padding()
        .background(Color.gray2)
        
    }
    
    
    @ViewBuilder
        func imageView(for image: UIImage?) -> some View {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .cornerRadius(40)
            }
            else {
                Button(action: {
                    imageViewModel.showActionSheet.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .font(.system(size: 40))
                })
                .frame(width: 80, height: 80)
                .background(.white)
                .cornerRadius(40)
                .actionSheet(isPresented: $imageViewModel.showActionSheet) {
                    imageViewModel.actionSheetView()

                }
            }
        }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
