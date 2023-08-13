//
//  DateBackgroundView.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 18/05/2023.
//

import SwiftUI

struct DateBackgroundView: View {
     var isSelected : Bool
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            Color.black
            
            //rectangle background
            Rectangle()
                .cornerRadius(MARGIN_MEDIUM)
                .foregroundColor(isSelected ? Color(BTN_COLOR) : Color(CHECKOUT_TICKET_TEXT_COLOR))
                .padding([.leading,.trailing],MARGIN_MEDIUM)
            
            //TopBar
            VStack{
                Color.black
                    .frame(width: MARGIN_MEDIUM_3,height: MARGIN_SMALL)
                    .cornerRadius(MARGIN_SMALL-2)
                    .padding(.bottom,MARGIN_XLLARGE)
            }
            
            //semi circle
            HStack{
                Circle()
                    .frame(width: MARGIN_MEDIUM_3, height: MARGIN_CARD_MEDIUM_2)
                    .foregroundColor(.black)
                
                Spacer()
                
                Circle()
                    .frame(width: MARGIN_MEDIUM_3, height: MARGIN_CARD_MEDIUM_2)
                    .foregroundColor(.black)
            }.padding(.bottom,MARGIN_MEDIUM_1)
            
        }.frame(width: DATE_BACKGROUND_WIDTH,height: DATE_BACKGROUND_HEIGHT)
    }
}

struct DateBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        DateBackgroundView(isSelected: false)
    }
}
