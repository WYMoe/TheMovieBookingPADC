//
//  ViewingTypeItemView.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 18/05/2023.
//

import SwiftUI

struct ViewingTypeItemView: View {
    var viewType:String = ""
    var body: some View {
        Text(viewType)
            .foregroundColor(.white)
            .font(.system(size: MARGIN_MEDIUM_2))
            .fontWeight(.medium)
            .padding(EdgeInsets(top: MARGIN_SMALL, leading: MARGIN_MEDIUM_1, bottom: MARGIN_SMALL, trailing: MARGIN_MEDIUM_1))
            .background(Color(CHECKOUT_TICKET_TEXT_COLOR))
            .cornerRadius(CORNER_RADIUS_SMALL)
            .overlay(
                RoundedRectangle(cornerRadius: CORNER_RADIUS_SMALL)
                    .stroke(.white
                           ,lineWidth: 1)
            )
    }
}

struct ViewingTypeItemView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            ViewingTypeItemView()
        }.edgesIgnoringSafeArea(.all)
    }
}
