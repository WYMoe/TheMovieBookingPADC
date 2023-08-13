//
//  TimeSlotScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 18/05/2023.
//

import SwiftUI

struct TimeSlotScreen: View {
    @Environment(\.dismiss) var dismiss
    @State var dates : [String] = [""]
    @State var cinemas : [CinemaVO]? = nil
    @State var userInfo : UserVO? = nil
    
    @State var cinemaCount : Int = 0
    @State var isPresented : Bool = false
    @State var isDatePresented : Bool = false
    @State var clickedDate : String = ""
    @State var timeslot : TimeSlotVO
    
    var movieTitle : String
    @State var cinemaForCheckout : String
    var screenStatus : Int
    var movieId: Int
    var cityId : Int
    var cityName : String
   
    let mBookingModel : MovieBookingModel = MovieBookingModelImpl.shared
    var body: some View {
      
            
            
            ZStack{
                //background
                Color.black
                
                
                //body
                VStack(spacing:0.0){
                    
                    //appbar
                    TimeSlotAppbarView(cityName : cityName){
                        dismiss()
                    }
                    
                    //Date list view
                    DateListView(dates: $dates, cinemasForClickedDate: $cinemas, clickedDate: $clickedDate, mBookingModel: mBookingModel, token: userInfo?.token ?? "").padding(.top,MARGIN_XLARGE)
                    
                    
                    //types
                    ViewingTypesView().padding(.top,MARGIN_XLARGE)
                    
                    //time slot colors
                    TimeSlotColorsView().padding(.top,MARGIN_XLARGE)
                    
                    //cinemas and timeslots
                    ScrollView(.vertical){
                        ForEach(cinemas ?? [CinemaVO()],id:\.cinemaId){
                            cinema in
                            
                            //item view
                            CinemaAndTimeSlotItemView(cinema: cinema, isTimeSlotsShowing: false, isSeparatorShown: cinema.cinemaId != cinemaCount, isPresented: $isPresented, timeslot: $timeslot,cinemaForCheckout: $cinemaForCheckout)
                            
                            
                        }
                    }
                    .padding(.bottom,MARGIN_LARGE)
                    
                }
                .padding(.top,MARGIN_XXLARGE)
                
            }.edgesIgnoringSafeArea([.top,.bottom,.leading,.trailing])
            .onAppear{
                self.dates = generateDates(for: 14)
                requestData()
                
            }
     
            .navigationDestination(isPresented: $isPresented, destination: {
                SeatingPlanScreen(token: userInfo?.token ?? "", timeslotId: timeslot.cinemaDayTimeSlotId ?? 0, clickedDate: clickedDate,cityId:cityId, cityName:cityName, movieTitle: movieTitle,cinema: cinemaForCheckout,screenStatus: timeslot.status ?? 0,selectedDate: clickedDate,selectedTime: timeslot.startTime ?? "", movieId: movieId)
            })
        .navigationBarBackButtonHidden(true)
    }
    
    func generateDates(for numberOfDays: Int) -> [String] {
        let calendar = Calendar.current
        let currentDate = Date()
        var dates: [String] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-d"
        
        for dayOffset in 0..<numberOfDays {
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: currentDate) {
                let dateString = dateFormatter.string(from: date)
                dates.append(dateString)
            }
        }
        
        return dates
    }
    
    func requestData(){
        //get token from database
        self.userInfo = mBookingModel.getUser()
        
        //get cinemas
       
        self.clickedDate = dates.first ?? ""
        mBookingModel.getCinemaAndShowtime(token: userInfo?.token ?? "", date: clickedDate ){ cinemas in
            self.cinemas = cinemas
            self.cinemaCount = cinemas.count
         
           
        } onFailure: { error in
           
        }
    }

}

struct TimeSlotScreen_Previews: PreviewProvider {
    static var previews: some View {
       // TimeSlotScreen(dates: [""] ,timeslot: TimeSlotVO(),movieTitle: "",cinema: "",screenStatus: 0)
        TimeSlotScreen(timeslot: TimeSlotVO(), movieTitle: "", cinemaForCheckout: "", screenStatus: 0,movieId: 0,cityId: 0,cityName: "")
    }
}


//app bar
struct TimeSlotAppbarView: View {
    var cityName : String
    var onTapBack: ()->Void = {
        
    }
    
    var body: some View {
        HStack{
            //back btn
            Image(systemName: IC_BACK)
                .resizable()
                .frame(width: MARGIN_MEDIUM_1,height: MARGIN_MEDIUM_3)
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .onTapGesture {
                    onTapBack()
                }
            Spacer()
            
            //location
            Image(systemName: IC_LOCATION)
                .resizable()
                .frame(width: MARGIN_MEDIUM_2,height: MARGIN_MEDIUM_2)
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
            
            //location name
            Text(cityName)
                .font(.system(size: MARGIN_MEDIUM_2))
                .foregroundColor(.white)
                .italic()
                .bold()
            
            Spacer().frame(width: MARGIN_LARGE)
            
            //search
            Image(systemName: IC_SEARCH)
                .resizable()
                .frame(width: MARGIN_MEDIUM_2,height: MARGIN_MEDIUM_2)
                .foregroundColor(.white)
            
            Spacer().frame(width: MARGIN_XLARGE)
            
            //filter
            
            Image(IC_FILTER)
                .resizable()
                .frame(width: MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
            
        }.padding([.leading,.trailing],MARGIN_MEDIUM_3)
    }
}



//date list view
struct DateListView: View {
    @Binding var dates : [String]
    @Binding var cinemasForClickedDate : [CinemaVO]?
    @Binding var clickedDate : String
    let mBookingModel : MovieBookingModel
    var token : String
    @State var isSelected : Bool = false
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing: MARGIN_SMALL) {
                ForEach(dates,id:\.self){
                    date in
                    //item
                    DateItemView(date: date,isSelected: date == clickedDate)
                        .onTapGesture {
                            
                            //get cinemas by clicked date
                            clickedDate = date
                           
                            print(clickedDate)
                            mBookingModel.getCinemaAndShowtime(token: token, date: date) { cinemas in
                            cinemasForClickedDate = cinemas
                                print("cinemas for selected date :\(date)")
                            } onFailure: { error in
                                
                            }

                        
                        }
                }
            }
        }
    }
}

//viewing types view
struct ViewingTypesView: View {
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing:MARGIN_MEDIUM_3){
                
                ViewingTypeItemView(viewType: "2D")
                ViewingTypeItemView(viewType: "3D")
                ViewingTypeItemView(viewType: "3D IMAX")
                ViewingTypeItemView(viewType: "3D DBOX")
            }.padding(.leading,MARGIN_MEDIUM_3)
                .padding(.trailing,MARGIN_XLARGE)
        }
    }
}

//time slot color view
struct TimeSlotColorsView: View {
    var body: some View {
        ZStack{
            HStack{
                
                TimeSlotColorItemView(color: BTN_COLOR,label: LABEL_AVAILABLE)
                
                Spacer()
                
                TimeSlotColorItemView(color: CANCEL_POLICY_BG,label:  LABEL_FILLING_FAST)
                    
                Spacer()
                
                TimeSlotColorItemView(color: ALMOST_FULL_COLOR,label: LABEL_ALMOST_FULL)
                
            }.padding([.leading,.trailing],MARGIN_MEDIUM_3)
        }.frame(height: MARGIN_XLARGE_2)
            .background(Color(TIMESLOT_COLOR_BG))
    }
}


//time slot color item
struct TimeSlotColorItemView: View {
    var color:String = ""
    var label:String = ""
    var body: some View {
        HStack(spacing: MARGIN_CARD_MEDIUM_2) {
            Circle()
                .frame(width: MARGIN_MEDIUM,height: MARGIN_MEDIUM)
                .foregroundColor(Color(color))
            
            
           Text(label)
                .foregroundColor(Color(color))
        }
    }
}
