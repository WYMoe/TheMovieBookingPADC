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

                   
                   //title
                   TitleTextView()
                    
                    
                   //search location
                   SearchLocationSection(locationText: $locationText)
                        
                   
                            
                    //building image
                   BuildingImgView()
                    
                   
                  //cities
                   CitiesSection(cities: cities)
                        
                    
                  
                }
               .padding(.top,UIScreen.main.bounds.height * 0.06)

               
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

struct TitleTextView: View {
    var body: some View {
        Text(LABEL_PICKREGION)
            .foregroundColor(Color(BTN_COLOR))
            .font(.system(size: TEXT_REGULAR_2X))
            .fontWeight(.heavy)
            .padding(.bottom,MARGIN_XLARGE)
    }
}

struct SearchTextFieldView: View {
    @Binding var locationText:String
    var body: some View {
        HStack{
            //search ic
            Image(systemName: IC_SEARCH)
                .foregroundColor(Color(BTN_COLOR))
                .frame(width: IC_SEARCH_WIDTH      ,height: IC_SEARCH_HEIGHT)
            
            //search text field
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
    }
}

struct SearchBtnView: View {
    @Binding var locationText:String
    var body: some View {
        Image(systemName: IC_LOCATION)
            .foregroundColor(.black)
            .frame(width: SEARCH_LOCATION_BTN_WIDTH,height: SEARCH_LOCATION_BTN_HEIGHT)
            .background(Color(BTN_COLOR))
            .cornerRadius(SEARCH_LOCATION_BTN_CORNER_RADIUS)
            .onTapGesture {
                print(locationText)
            }
    }
}

struct SearchLocationSection: View {
    @Binding var locationText:String
    var body: some View {
        HStack(spacing:20.0){
            
            SearchTextFieldView(locationText:$locationText)
            
            SearchBtnView(locationText: $locationText)
            
        }.padding(.bottom,MARGIN_XLARGE)
    }
}

struct BuildingImgView: View {
    var body: some View {
        HStack{
            Spacer()
            //building ic
            Image(IC_BUILDING)
            
        }
    }
}

struct CitiesTitleView: View {
    var body: some View {
        ZStack(alignment:.leading){
            
            Color(PRIMARY_DARK_COLOR)
            
            //cities
            Text(LABEL_CITIES)
                .foregroundColor(.white)
                .font(.system(size:TEXT_REGULAR_2X))
                .padding(.leading,MARGIN_MEDIUM_3)
        }
        .frame(width: UIScreen.main.bounds.width,height: MARGIN_XLARGE_2)
    }
}

struct CityNameView: View {
    var city:String
    var body: some View {
        VStack(alignment:.leading,spacing: 0.0){
            
            
            //city
            Text(city)
                .foregroundColor(.white)
                .padding(MARGIN_MEDIUM_3)
            
            
            //divider
            Rectangle()
                .foregroundColor(Color(PRIMARY_DARK_COLOR))
                .frame(height: 1)
            
            
            
        }.frame(width: UIScreen.main.bounds.width,height: MARGIN_XXLARGE_2)
    }
}

struct CitiesSection: View {
    var cities: [String]
    var body: some View {
        Group {
            
            //cities title
           CitiesTitleView()
            
            
            
            //city name
            ForEach(cities,id:\.self){ city in
                
                CityNameView(city: city)
                
            }
        }
    }
}
