//
//  SplashScreenview.swift
//  syncaid
//
//  Created by AhmedFatma on 14/11/2022.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View {
        if isActive {
            WelcomeView()
        }
        else {
            VStack {
                VStack{
                    Image("Logo")
                        .resizable()
                        .frame(width: 200,height: 200)                           .foregroundColor(.red)
                                 }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.5)){
                        self.size = 0.9
                        self.opacity = 1.00
                    }
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    withAnimation{
                        self.isActive = true
                        
                    }
                }
                var model = SyncService()
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
