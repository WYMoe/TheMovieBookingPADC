//
//  RegionScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 07/05/2023.
//

import SwiftUI

struct RegionScreen: View {
    @State var locationText:String
    
    
    let cities = ["Yangon","Mandalay","Naypyidaw","Bago","Mawlamyine"]
    var body: some View {
       NavigationStack {
            
        ZStack(alignment:.top) {
               Color(PRIMARY_COLOR)
            
               VStack(spacing:0.0){
                   Spacer()
                       .frame(height: UIScreen.main.bounds.height * 0.06)
                   Text(LABEL_PICKREGION)
                   .foregroundColor(Color(BTN_COLOR))
                   .font(.system(size: TEXT_REGULAR_2X))
                   .fontWeight(.heavy)
                   .padding(.bottom,MARGIN_XLARGE)
                    
                    
                   
                   HStack(spacing:20.0){
                            
                            HStack{
                                
                                Image(systemName: IC_SEARCH)
                                    .foregroundColor(Color(BTN_COLOR))
                                    .frame(width: IC_SEARCH_WIDTH      ,height: IC_SEARCH_HEIGHT)
                                
                                ZStack(alignment:.leading){
                                    if locationText.isEmpty {
                                        Text(LABEL_SEARCH_LOCATION)
                                            .foregroundColor(Color(LABEL_COLOR))
                                    }
                                TextField("", text:$locationText)
                                        .foregroundColor(Color((PRIMAYR_LIGHT_COLOR)))
                                        
                                }
                                    
                                 
                    
                            

                            }.padding(MARGIN_MEDIUM_2)
                                .frame(width:SEARCH_LOCATION_TEXTFIELD_WIDTH,height: SEARCH_LOCATION_TEXTFIELD_HEIGHT)
                                .background(Color(PRIMARY_DARK_COLOR))
                                .cornerRadius(SEARCH_LOCATION_TEXTFIELD_CORNER_RADIUS)
                            
                            Image(systemName: IC_LOCATION)
                                .foregroundColor(.black)
                                .frame(width: SEARCH_LOCATION_BTN_WIDTH,height: SEARCH_LOCATION_BTN_HEIGHT)
                                .background(Color(BTN_COLOR))
                                .cornerRadius(SEARCH_LOCATION_BTN_CORNER_RADIUS)
                                .onTapGesture {
                                    print(locationText)
                                }
                            
                        }.padding(.bottom,MARGIN_XLARGE)
                        
                   
                            
                        
                        HStack{
                            Spacer()
                            Image(IC_BUILDING)
                            
                        }
                        
                        
                        
                        
                        
                        
                        ZStack(alignment:.leading){
                            Color(PRIMARY_DARK_COLOR)
                            Text(LABEL_CITIES)
                                .foregroundColor(.white)
                                .font(.system(size:TEXT_REGULAR_2X))
                                .padding(.leading,MARGIN_MEDIUM_3)
                        }
                        .frame(width: UIScreen.main.bounds.width,height: MARGIN_XLARGE_2)
                        
                        
                        
             
                            ForEach(cities,id:\.self){ city in
                            
                                VStack(alignment:.leading,spacing: 0.0){
                                   
                                        Text(city)
                                            .foregroundColor(.white)
                                            .padding(MARGIN_MEDIUM_3)
                                            
                                    
                                    
                                    Rectangle()
                                        .foregroundColor(Color(PRIMARY_DARK_COLOR))
                                        .frame(height: 1)
                                        
                                        
                                    
                                }.frame(width: UIScreen.main.bounds.width,height: MARGIN_XXLARGE_2)
                                
                            }
                    
                  
                }

               
            }.edgesIgnoringSafeArea([.top,.bottom])
               .navigationBarBackButtonHidden(true)
            
            
        }
    }
}

struct RegionScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegionScreen(locationText: "")
    }
}
