//
//  MovieSeatsZoomableContainerView.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 19/05/2023.
//

import SwiftUI

struct MovieSeatsZoomableContainerView: View {
    
    //child view
    var view: AnyView? = nil
    var viewHeight: Double = 0.0
    
    //states
    @State private var zoomLevel: Double = 1.0
    @State private var offset:CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    @Environment(\.presentationMode) var presentation
    var body: some View {
        
        let drag = DragGesture()
            .onChanged{
                value in
                
                if zoomLevel != 1 {
                    self.offset = CGSize(width: value.translation.width + self.lastOffset.width, height: value.translation.height + self.lastOffset.height)
                }
            }.onEnded{
                value in
                
                if zoomLevel != 1 {
                    self.offset = CGSize(width: value.translation.width + self.lastOffset.width, height: value.translation.height + self.lastOffset.height)
                    self.lastOffset = self.offset
                }
                
            }
        
        VStack(spacing: 0) {
            //zoomable view
            view?.scaledToFit()
                .scaleEffect(zoomLevel)
                .offset(x:offset.width,y: offset.height)
                .gesture(drag)
                .frame(width:UIScreen.main.bounds.width,height: viewHeight)
                .clipped()
            
            //seats color view
            SeatsColorView()
            
            //zoom slider
            ZoomSliderView(zoomLevel: $zoomLevel, offset: $offset,lastOffset: $lastOffset)
                .padding(.top,MARGIN_XLARGE)
            
            //ticket price and buy ticket
            NavigationLink{
                SnackScreen(isSnackCartShowing: false)
            } label:{
                TicketsPriceAndBuyTicketView()
            }
            
                
            
        }.background(.black)
    }
}

struct MovieSeatsZoomableContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSeatsZoomableContainerView()
    }
}

struct SeatColorItemView: View {
    var text: String = ""
    var color: String = ""
    var body: some View {
        HStack(spacing:MARGIN_MEDIUM) {
            Circle()
                .frame(width: MARGIN_MEDIUM,height: MARGIN_MEDIUM)
                .foregroundColor(Color(color))
                .overlay(Circle().stroke(Color(TIMESLOT_COLOR_BG),lineWidth: 1))
            
            Text(text)
                .foregroundColor(Color(LABEL_COLOR))
                .font(.system(size: MARGIN_MEDIUM_2))
        }
    }
}

struct SeatsColorView: View {
    var body: some View {
        ZStack {
            HStack {
                
                
                //seat color item view
                SeatColorItemView(text: "Available",color: PRIMARY_LIGHT_COLOR)
                Spacer()
                SeatColorItemView(text: "Taken",color: PRIMARY_DARK_COLOR)
                Spacer()
                SeatColorItemView(text: "Your Selection",color: BTN_COLOR)
                
                
            }.padding([.leading,.trailing], MARGIN_MEDIUM_3)
            
            
        }.frame(height: MARGIN_XLARGE_2)
            .background(Color(TIMESLOT_COLOR_BG))
    }
}



struct ZoomSliderView: View {
    @Binding var zoomLevel: Double
    @Binding var offset: CGSize
    @Binding var lastOffset: CGSize
    var body: some View {
        HStack{
            Text("-")
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_3))
            
            
            Slider (value: Binding(get: {
                zoomLevel
                
            }, set: { newValue in
                zoomLevel = newValue
                offset = CGSize.zero
                lastOffset = CGSize.zero
            }),
                    in: 1...3, step: 0.1)
            .padding(.horizontal)
            .accentColor(Color(PRIMARY_LIGHT_COLOR))
            
            Text("+")
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_3))
        }.padding([.leading,.trailing],MARGIN_XXLARGE_2)
    }
}

struct TicketsPriceAndBuyTicketView: View {
    var body: some View {
        HStack(spacing: MARGIN_XLARGE_2) {
            //tickets and price
            VStack{
                Text("2 Tickets")
                    .foregroundColor(.white)
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .fontWeight(.semibold)
                
                Text("20000Ks")
                    .foregroundColor(Color(BTN_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_3))
                    .fontWeight(.semibold)
            }
            
            //buy ticket button
            ZStack{
                Image(IC_BUY_TICKET_BTN_BG)
                    .resizable()
                    .frame(height: MARGIN_XXLARGE)
                
                Text(LABEL_BUY_TICKET)
                    .foregroundColor(.black)
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .fontWeight(.semibold)
                    .frame(width: MARGIN_XLLARGE,height: MARGIN_XXLARGE)
                    .background(Color(BTN_COLOR))
            }
            
        }
        .padding(.top,MARGIN_XLARGE_2)
        .padding([.leading,.trailing],MARGIN_LARGE_1)
    }
}
