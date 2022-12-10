import SwiftUI
import Foundation
import UIKit

class RoleViewHostingController: UIHostingController<RoleView> {
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder, rootView: RoleView())
    }
}

struct RoleView:View{
    @State private var isSelected=false
    @State private var isSelected2=false
    var body: some View{
 
        VStack(alignment:.center,spacing: 100)
        {
         
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing:20) {
                Text("Choose your role as a user")
                    .bold()
                    .font(.system(size: 20, weight: .medium)
                    )
                    .multilineTextAlignment(.center)
            }
            
            VStack(alignment: .center, spacing: 20) {
                PatientSelectButton(isSelected: $isSelected, color:.white,color2: .cyan).onTapGesture {
                    isSelected.toggle()
                    
                    if isSelected{
                        isSelected2=false
                    }
                }
                GuardianSelectButton(isSelected: $isSelected2, color:.white,color2: .cyan).onTapGesture {
                    isSelected2.toggle()
                    
                    if isSelected2{
                        isSelected=false
                    }
                }
            }
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20){
                
                NavigationLink(destination:WelcomeView())
                {
                    ZStack{
                        Capsule()
                            .frame(width:150,height: 50)
                            .background(.cyan)
                            .foregroundColor(.cyan)
                            .cornerRadius(30)
                            .overlay(
                                Capsule(style:.continuous)
                                    .stroke(Color.cyan,lineWidth: 2)
                            )
                        HStack{
    
                            
                            
                            HStack{
                                Text("Next")
                                    .foregroundColor(.white)
                                
                                    .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                   
                                
                            }
                         
                            
                        }

                    }
                }
            }
        }
    }}
    


struct RoleViewPreview: PreviewProvider {
    static var previews: some View {
        RoleView()
    }
}



