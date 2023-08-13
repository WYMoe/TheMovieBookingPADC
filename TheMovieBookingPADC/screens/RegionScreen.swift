//
//  RegionScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 07/05/2023.
//

import SwiftUI

struct RegionScreen: View {
    @State var locationText:String = ""
    @State var userId : Int
    @State var isPresented : Bool = false
    @State var cityId : Int = 0
    @State var cityName : String = ""
   // let cities = ["Yangon","Mandalay","Naypyidaw","Bago","Mawlamyine"]
    
    
    @State var cities : [CityVO]? = nil
    @State var userInfo : UserVO? = nil
    let mBookingModel : MovieBookingModel = MovieBookingModelImpl.shared

    var body: some View {
       
            
           
           //zstack
        ZStack(alignment:.top) {
               Color(PRIMARY_COLOR)
            
           // VStack
               VStack(spacing:0.0){

                   
                   //title
                   TitleTextView()
                    
                    
                   //search location
                   SearchLocationSection(locationText: $locationText)
                        
                   
                            
                    //building image
                   BuildingImgView()
                    
                   
                  //cities
                   CitiesSection(mBookingModel: self.mBookingModel,token: self.userInfo?.token ?? "",cities: cities ?? [],isPresented: $isPresented,cityId:  $cityId,cityName:$cityName)
                        
                    
                  
                }
               .padding(.top,UIScreen.main.bounds.height * 0.06)

               
            }.edgesIgnoringSafeArea([.top,.bottom])
            .onAppear{
                requestData()
            }
            .navigationDestination(isPresented: $isPresented, destination: {
                MainScreen(selection: 1,cityId: cityId,cityName:cityName)
            })
               .navigationBarBackButtonHidden(true)
        
               
            
        
    }
    
   

    func requestData(){
        //get cities
        mBookingModel.getCities { cities in
            self.cities = cities
            
        } onFailure: { error in
            
        }
      
        //get token from database
        self.userInfo = mBookingModel.getUser()
        
        print("region screen: userInfo from db \(self.userInfo ?? UserVO())")
        
       
        


        
    }
}

struct RegionScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegionScreen( userId: 0)
    }
}


//title text
struct TitleTextView: View {
    var body: some View {
        Text(LABEL_PICKREGION)
            .foregroundColor(Color(BTN_COLOR))
            .font(.system(size: TEXT_REGULAR_2X))
            .fontWeight(.heavy)
            .padding(.bottom,MARGIN_XLARGE)
    }
}

//search textfield
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
                    .foregroundColor(Color((PRIMARY_LIGHT_COLOR)))
                
            }
            
            
            
            
            
        }.padding(MARGIN_MEDIUM_2)
            .frame(width:SEARCH_LOCATION_TEXTFIELD_WIDTH,height: SEARCH_LOCATION_TEXTFIELD_HEIGHT)
            .background(Color(PRIMARY_DARK_COLOR))
            .cornerRadius(SEARCH_LOCATION_TEXTFIELD_CORNER_RADIUS)
    }
}

//search btn
struct SearchBtnView: View {
    @Binding var locationText:String
    var body: some View {
        Image(systemName: IC_LOCATION)
            .foregroundColor(.black)
            .frame(width: SEARCH_LOCATION_BTN_WIDTH,height: SEARCH_LOCATION_BTN_HEIGHT)
            .background(Color(BTN_COLOR))
            .cornerRadius(SEARCH_LOCATION_BTN_CORNER_RADIUS)
            
    }
}


//search location section
struct SearchLocationSection: View {
    @Binding var locationText:String
    var body: some View {
        HStack(spacing:20.0){
            //textfield
            SearchTextFieldView(locationText:$locationText)
            
            
            NavigationLink{
             //   MainScreen(selection: 1)
            }label: {
                SearchBtnView(locationText: $locationText)
            }
            
            
        }.padding(.bottom,MARGIN_XLARGE)
    }
}

//builing img
struct BuildingImgView: View {
    var body: some View {
        HStack{
            Spacer()
            //building ic
            Image(IC_BUILDING)
            
        }
    }
}


//cities title
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


//city name row view
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


//cities
struct CitiesSection: View {
    let mBookingModel : MovieBookingModel
    var token : String
    var cities: [CityVO]
    @Binding var isPresented : Bool
    @Binding var cityId : Int
    @Binding var cityName : String
    var body: some View {
        Group {
            
            //cities title
           CitiesTitleView()
            
            
            
            //city name
            ForEach(cities,id:\.id){ city in
                
                
                CityNameView(city: city.name ?? "").onTapGesture {
                    mBookingModel.setCity(token: token, cityId: city.id ?? 0) { vo in
                        print("region screen : set city \(vo.message ?? "")")
                        
                        if  vo.message == "Success" {
                            isPresented = true
                            cityId = city.id ?? 0
                            cityName = city.name ?? ""

                        }
                    } onFailure: { error in

                    }
                  

                }
                   
                
                
            }
        }
    }
}
