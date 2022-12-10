//
//  Welcomepage.swift
//  syncaid
//
//  Created by AhmedFatma on 14/11/2022.
//
import GoogleSignIn
import SwiftUI

class WelcomeViewHostingController: UIHostingController<WelcomeView> {
    required init?(coder aDecoder:NSCoder){
        super.init(coder: aDecoder, rootView: WelcomeView())
        
   
        func application(
              _ app: UIApplication,
              open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
            ) -> Bool {
              var handled: Bool

              handled = GIDSignIn.sharedInstance.handle(url)
              if handled {
                return true
              }

              // Handle other custom URL types.

              // If not handled by this app, return false.
              return false
            }
    }
}


struct WelcomeView: View {
    
    var body: some View { 
        NavigationView{
            ZStack {
                VStack(alignment: .center,spacing:20) {
                    Image("Doctor")
                    HStack(){
                        VStack(){
                            Text("Welcome to Syncaid")
                                .bold()
                                .font(.system(size: 25, weight: .medium)
                                )
                                .multilineTextAlignment(.center)
                            
                            
                            
                            Text("Let us help you with your journey! Join us now and we will be with you every step of the way")
                                .foregroundColor(.gray)
                                .font(.system(size:18,weight:.light))
                                .padding(30)
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    VStack(spacing:15){
                        VStack(){
                            HStack{
                                NavigationLink(destination:LoginRepresentable()){
                                    Text("Already a member?")
                                    
                                    .frame(width:300,height: 60)
                                    .background(Color("btncolor1"))
                                    .foregroundColor(.white)
                                    .cornerRadius(30)
                                }
                                
                            }
                            
                            
                        
                                   
                            
                            NavigationLink(destination: SignupRepresentable() ){
                                Text("Become a member!")
                                
                                    .frame(width:300,height: 60)
                                    .background(Color.white)
                                    .foregroundColor(Color("btncolor1"))
                                    .overlay(
                                        Capsule(style:.continuous)
                                            .stroke(Color("btncolor1"),lineWidth: 2)
                                    )
                            }
                        }
                    }
                }
            }
        }
        .padding(.top, -50)
    }}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
