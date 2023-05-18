//
//  CinemaAndTimeSlotItemView.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 18/05/2023.
//

import SwiftUI

struct CinemaAndTimeSlotItemView: View {
    
    @State var isTimeSlotsShowing:Bool
     var isSeparatorShown: Bool
    var body: some View {
        VStack{
          
            //item body
            VStack(alignment: .leading,spacing: 0.0) {
                
                //cinema name and see details
                CinemaNameAndSeeDetailsView()
                
                //cinema facilities
                CinemaFacilitiesView()
                    .padding(.top,MARGIN_MEDIUM_3)
           
            
            //Time slots and hint
            if isTimeSlotsShowing {
                VStack(alignment: .leading,spacing: 0.0) {
                    
                    //time slot view
                    TimeSlotView()
                        .padding(.top,MARGIN_MEDIUM_3)
                    
                    //long press hint
                    LongPressHintView()
                        .padding(.top,MARGIN_LARGE)
                }
            } else {
                
                EmptyView()
            }
            
            }.padding(EdgeInsets(top: MARGIN_XLARGE, leading: MARGIN_LARGE, bottom: MARGIN_XLARGE, trailing: MARGIN_LARGE))
                .onTapGesture {
                    withAnimation{
                        isTimeSlotsShowing.toggle()
                        
                    }
                }
                
            //separator
            if isSeparatorShown {
                Rectangle()
                    .frame(height: MARGIN_SMALL_1)
                    .foregroundColor(Color(LABEL_COLOR))
            }else {
                EmptyView()
            }
            
            
        }
        .background(.black)
        
    }
}

struct CinemaAndTimeSlotItemView_Previews: PreviewProvider {
    static var previews: some View {
        CinemaAndTimeSlotItemView(isTimeSlotsShowing: true,isSeparatorShown: true)
    }
}

struct CinemaNameAndSeeDetailsView: View {
    var body: some View {
        HStack{
            Text("JCGV Junction City")
                .foregroundColor(Color(.white))
                .font((.system(size: MARGIN_MEDIUM_2)))
                .fontWeight(.medium)
            
            Spacer()
            
            Text("See Details")
                .foregroundColor(Color(BTN_COLOR))
                .font(.system(size: MARGIN_MEDIUM_2))
                .underline()
        }
    }
}

struct CinemaFacilitiesView: View {
    var body: some View {
        HStack(spacing: MARGIN_MEDIUM_2) {
            FacilityItem(icon: IC_PARKGING,label: LABEL_PARKING)
            FacilityItem(icon: IC_SNACK_GRAY,label: LABEL_ONLINE_FOOD)
            FacilityItem(icon: IC_WHEELCHAIR,label: LABEL_WHEELCHAIR)
        }
    }
}

struct FacilityItem: View {
    var icon:String = ""
    var label:String = ""
    var body: some View {
        HStack(spacing: MARGIN_MEDIUM) {
            Image(icon)
                .resizable()
                .frame(width: MARGIN_MEDIUM_2,height: MARGIN_MEDIUM_2)
            
            Text(label)
                .foregroundColor(Color(LABEL_COLOR))
        }
    }
}

struct TimeSlotView: View {
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible(minimum: DATE_BACKGROUND_HEIGHT),spacing: MARGIN_LARGE_1),
                            GridItem(.flexible(minimum: DATE_BACKGROUND_HEIGHT),spacing: MARGIN_LARGE_1),
                            GridItem(.flexible(minimum: DATE_BACKGROUND_HEIGHT),spacing: MARGIN_LARGE_1)]) {
            ForEach(1...6,id:\.self){
                number in
                NavigationLink(value: number) {
                    
                    //timeslotitemview
                    TimeSlotItemView()
                    
                }.buttonStyle(.plain)
            }
        }
    }
}

struct TimeSlotItemView: View {
    var body: some View {
        VStack(spacing: MARGIN_SMALL) {
            Text("11:30 PM")
                .foregroundColor(.white)
                .font(.system(size: MARGIN_MEDIUM_1))
            
            Text("3D IMAX")
                .foregroundColor(.white)
                .font(.system(size: MARGIN_CARD_MEDIUM_2))
            
            Text("Screen 1")
                .foregroundColor(.white)
                .font(.system(size: MARGIN_CARD_MEDIUM_2))
            
        }.padding(EdgeInsets(top: MARGIN_MEDIUM, leading: MARGIN_MEDIUM_2, bottom: MARGIN_MEDIUM, trailing: MARGIN_MEDIUM_2))
            .frame(height: TIMESLOT_ITEM_VIEW_HEIGHT)
            .overlay(RoundedRectangle(cornerRadius: CORNER_RADIUS_SMALL)
                .stroke(Color(BTN_COLOR), lineWidth:1))
    }
}

struct LongPressHintView: View {
    var body: some View {
        HStack {
            Image(IC_INFO)
                .resizable()
                .frame(width: MARGIN_MEDIUM_2,height: MARGIN_MEDIUM_2)
            
            
            Text(LABEL_LONGPRESS)
                .foregroundColor(Color(LABEL_COLOR))
                .font(.system(size:MARGIN_MEDIUM_1))
        }
    }
}
