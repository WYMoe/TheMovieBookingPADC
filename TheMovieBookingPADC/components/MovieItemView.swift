//
//  MovieItemView.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 10/05/2023.
//

import SwiftUI

struct MovieItemView: View {
    @Binding var isActiveComingSoon:Bool
    
    
    
    var body: some View {
        ZStack{
            Color(.black)
            VStack(alignment: .leading, spacing:0.0){
                ZStack(alignment:.topTrailing){
                    
                    Image("Movie")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 170,height: 212)
                   
               
                    
                    if isActiveComingSoon {
                        Text("8th \n AUG")
                            .padding(5)
                            .font(.system(size: 10))
                            .multilineTextAlignment(.center)
                            .background(Color(BTN_COLOR))
                            .cornerRadius(8)
                            .frame(width: 35,height: 35)
                            .padding(7)
                        
                    } else {
                        
                        
                      Text("")
                        
                        
                    }
                    LinearGradient(colors: [.clear,.clear,.clear,.black], startPoint: .top, endPoint: .bottom)
                    
                    
                    
                }
                
                
                
                HStack{
                    Text("Venom")
                        .foregroundColor(Color(PRIMAYR_LIGHT_COLOR))
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 12))
                    
                    Spacer()
                    
                    Image("imdb")
                    Text("9.0")
                        .foregroundColor(Color(PRIMAYR_LIGHT_COLOR))
                        .font(.system(size: 12))
                        .italic()
                        .fontWeight(.bold)
                    
                    
                    
                }.padding(.leading,7)
                    .padding(.trailing,7)
                
                HStack{
                    Text("U/A")
                        .foregroundColor(Color(PRIMAYR_LIGHT_COLOR))
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                    
                    
                    Circle()
                        .foregroundColor(Color(PRIMAYR_LIGHT_COLOR))
                        .frame(width: 5,height: 5)
                    
                    Text("2D, 3D, IMAX") .foregroundColor(Color(PRIMAYR_LIGHT_COLOR))
                        .font(.system(size: 10))
                    
                    
                    
                }.padding(.leading,7)
                    .padding(.trailing,7)
                
            }.padding(.bottom,22)
            
            
            
            
            
        }.frame(width: 170,height: 212)
        
        
    }
}

struct MovieItemView_Previews: PreviewProvider {
    static var previews: some View {
        MovieItemView(isActiveComingSoon: .constant(false))
    }
}
