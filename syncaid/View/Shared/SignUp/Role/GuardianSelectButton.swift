import SwiftUI

struct GuardianSelectButton:View{
    @Binding var isSelected:Bool
    @State var color: Color
    @State var color2:Color
    
    
    var body: some View{
        ZStack{
            Capsule()
                .frame(width:300,height: 60)
                .background(isSelected ? color:.cyan)
                .foregroundColor(isSelected ? color2:.white)
                .cornerRadius(30, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .overlay(
                    Capsule(style:.continuous)
                        .stroke(Color.cyan,lineWidth: 2)
                )
            Text("Guardian")
                .foregroundColor(isSelected ? color:.cyan)
        }
    }
}
struct GuardianSelectButton_Previews:PreviewProvider{
    static var previews: some View{
        GuardianSelectButton(isSelected: .constant(false),color:.white,color2: .cyan)
    }
}

