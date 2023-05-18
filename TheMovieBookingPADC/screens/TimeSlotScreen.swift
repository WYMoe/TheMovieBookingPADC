//
//  TimeSlotScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 18/05/2023.
//

import SwiftUI

struct TimeSlotScreen: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            
            
            ZStack{
                //background
                Color.black
                
                
                //body
                VStack(spacing:0.0){
                    
                    //appbar
                    TimeSlotAppbarView(){
                        dismiss()
                    }
                    
                    //Date list view
                    DateListView().padding(.top,MARGIN_XLARGE)
                    
                    
                    //types
                    ViewingTypesView().padding(.top,MARGIN_XLARGE)
                    
                    //time slot colors
                    TimeSlotColorsView().padding(.top,MARGIN_XLARGE)
                    
                    //cinemas and timeslots
                    ScrollView(.vertical){
                        ForEach(1...10,id:\.self){
                            number in
                            
                            //item view
                            CinemaAndTimeSlotItemView(isTimeSlotsShowing: false, isSeparatorShown: number != 10)
                        }
                    }
                    .padding(.bottom,MARGIN_LARGE)
                    
                }
                .padding(.top,MARGIN_XXLARGE)
                
            }.edgesIgnoringSafeArea([.top,.bottom,.leading,.trailing])
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct TimeSlotScreen_Previews: PreviewProvider {
    static var previews: some View {
        TimeSlotScreen()
    }
}

struct TimeSlotAppbarView: View {
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
            Text("Yangon")
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



struct DateListView: View {
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing: MARGIN_SMALL) {
                ForEach(1...14,id:\.self){
                    date in
                    //item
                    DateItemView()
                }
            }
        }
    }
}

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

struct TimeSlotColorsView: View {
    var body: some View {
        ZStack{
            HStack{
                TimeSlotColorItemView(color: BTN_COLOR,label: "Available")
                Spacer()
                TimeSlotColorItemView(color: CANCEL_POLICY_BG,label: "Filling Fast")
                    
                Spacer()
                TimeSlotColorItemView(color: ALMOST_FULL_COLOR,label: "Almost Full")
            }.padding([.leading,.trailing],MARGIN_MEDIUM_3)
        }.frame(height: MARGIN_XLARGE_2)
            .background(Color(TIMESLOT_COLOR_BG))
    }
}

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
