//
//  syncaidapp.swift
//  syncaid
//
//  Created by AhmedFatma on 14/11/2022.
//

import SwiftUI


@main
struct syncaidapp: App {
    @AppStorage("isDarkMode") var isDarkMode = false 
    var body: some Scene {
        
       
        
            WindowGroup{
              
                    SplashScreenView()
 
                
            }
        }
    
    
        }
	
