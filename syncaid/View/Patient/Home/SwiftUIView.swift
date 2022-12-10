//
//  SwiftUIView.swift
//  syncaid
//
//  Created by AhmedFatma on 28/11/2022.
//

import SwiftUI
import Charts
import SwiftUICharts
class HomeViewHostingController: UIHostingController<SwiftUIView> {
    required init?(coder aDecoder:NSCoder){
        super.init(coder: aDecoder, rootView: SwiftUIView())
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.hidesBackButton = true
       
    }
}

struct SwiftUIView: View {
    var body: some View {
       // let defaults = UserDefaults.standard
        
      //  let name = defaults.object(forKey: "FIRSTNAME") as! String
        ZStack{
               
            VStack{
                HStack {
                
                  CardView()
                        .background(Color.white)
                          //.previewLayout(.fixed(width: 400, height: 60))
                          .background(Color.white)
                           .foregroundColor(.white)
                         .cornerRadius(20)
                         .shadow(
                color: .gray,
                radius: CGFloat(10),
                x: CGFloat(5), y: CGFloat(5))
                         
                    
            }.padding(10)
              
             //   Text("Hi !").font(.system(size: 36, weight: .bold, design: .monospaced))
                HStack{
                    VStack {
                        MultiLineChartView(data: [([8,32,11,23,40,28], GradientColors.prplNeon), ([90,99,78,111,70,60,77], GradientColors.purple), ([34,56,72,38,43,100,50], GradientColors.blue)], title: "Heart rate",style: ChartStyle(backgroundColor: Color.ui.bg, accentColor:Color.accentColor, secondGradientColor: Color.pink,  textColor: Color.black, legendTextColor: Color.accentColor, dropShadowColor: Color.gray))
                    }
                 
                                       
                    
                    LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "O2 levels", legend: "Legendary", style:  ChartStyle(backgroundColor: Color.ui.bg, accentColor:Color.accentColor, secondGradientColor: Color.pink,  textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.gray))
                }
                
                
                HStack{
                    
                    PieChartView(data: [10,90,98,1000], title: "Blood oxygen",style: ChartStyle(backgroundColor: Color.ui.bg, accentColor: Color.cyan, secondGradientColor: Color.cyan,  textColor: Color.black, legendTextColor: Color.gray, dropShadowColor: Color.gray))
             
                    
                    BarChartView(data: ChartData(values: [("2 min",13150), ("15 min",15900), ("8min",17550), ("20 min",20600), ("5 min",30550)]), title: "Weekly faints", legend: "Per day",style: ChartStyle(backgroundColor: Color.ui.bg, accentColor: Color.accentColor, secondGradientColor: Color.purple,  textColor: Color.black, legendTextColor: Color.gray, dropShadowColor: Color.gray)) // legend is optional
                }.padding()
                
                
                
                
            }
        }
          
    }
      
    }
    
    extension Color {
        static let ui = Color.UI()
        struct UI {
            let bg = Color("ChartBg")
        }
    }

    
    struct ToyShape: Identifiable {
        var type: String
        var count: Double
        var id = UUID()
    }
    var data: [ToyShape] = [
        .init(type: "Cube", count: 5),
        .init(type: "Sphere", count: 4),
        .init(type: "Pyramid", count: 4)
    ]
    
    struct SwiftUIView_Previews: PreviewProvider {
        static var previews: some View {
            SwiftUIView()
        }
    }



struct CardView: View {


    var body: some View {
        VStack(alignment: .leading) {
            HStack(){
                Image("ahmed4")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                
                Text("Welcome back")
                    .font(.headline)
                    .accessibilityAddTraits(.isHeader)
            }
        
            Spacer()
            HStack {
                Label("count", systemImage: "person.3")
                Spacer()
                Label("sdfs", systemImage: "clock")
                    
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(Color.black)
    }
}

