//
//  SeatingPlanScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 19/05/2023.
//

import SwiftUI

struct SeatingPlanScreen: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
        NavigationStack {
            ZStack{
                Color.black
                VStack(spacing:0.0){
                    //Appbar
                    SeatingPlanAppbarView{
                        presentation.wrappedValue.dismiss()
                    }
                    
                    //screen view
                    ScreenView().padding(.top,MARGIN_MEDIUM_2)
                    
                    //price label
                    Text("Normal (4500Ks)")
                        .foregroundColor(Color(LABEL_COLOR))
                        .font(.system(size: MARGIN_MEDIUM_2))
                        .padding(.bottom,MARGIN_MEDIUM)
                    
                    
                    //movie seats
                    MovieSeatsZoomableContainerView(
                        view: AnyView(MovieSeatView()),
                        viewHeight: 300
                    ).padding([.leading,.trailing], MARGIN_SMALL)
                  
                    Spacer()
                    
                    
                }.padding(.top,MARGIN_XXLARGE)
                
            }.edgesIgnoringSafeArea(.all)
                .navigationBarBackButtonHidden(true)
        }
            
    }
}

struct SeatingPlanScreen_Previews: PreviewProvider {
    static var previews: some View {
        SeatingPlanScreen()
    }
}

struct SeatingPlanAppbarView: View {
    
    
    var onTapBack:()->Void = {
        
    }
    var body: some View {
        HStack{
            Image(systemName: IC_BACK)
                .resizable()
                .frame(width: MARGIN_CARD_MEDIUM_2,height: MARGIN_MEDIUM_3)
                .foregroundColor(.white)
            Spacer()
            
        }.padding([.leading,.trailing],MARGIN_MEDIUM_3)
            .onTapGesture {
                onTapBack()
            }
    }
}

struct ScreenView: View {
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            Image(IC_SCREEN)
                .resizable()
                .frame(width: IC_SCREEN_WIDTH,height: IC_SCREEN_HEIGHT)
                .clipped()
            
            Text(LABEL_SCREEN)
                .foregroundColor(.white)
                .font(.system(size: MARGIN_MEDIUM_2))
                .padding(.bottom,MARGIN_LARGE)
        }
    }
}


struct MovieSeatView: View {
    var columns = getGridItems(numberOfColumns: 18, spacing: 7)
    
    var body: some View {
        LazyVGrid(columns: columns,spacing: 10) {
            ForEach(dummy_seats,id:\.id){
                seat in
                MovieSeatItemView(seat: seat)
            }
           
        }
    }
}

struct MovieSeatItemView: View {
    var seat:MovieSeatVO? = nil
    var body: some View {
            if seat?.isAvailable() ?? false {
                Image(IC_SEAT_AVAILABLE)
                    .resizable()
                    .frame(width: MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
                    .clipped()
                
            }else if seat?.isTaken() ?? false {
                Image(IC_SEAT_TAKEN)
                    .resizable()
                    .frame(width: MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
                    .clipped()
            }else if seat?.isText() ?? false {
                
                Text(seat?.text ?? "")
                    .font(.system(size:MARGIN_CARD_MEDIUM_2))
                    .frame(width:MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
                    .foregroundColor(Color(LABEL_COLOR))
            }else {
                Color.clear
                    .frame(width: MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
            }
        }
    
}
