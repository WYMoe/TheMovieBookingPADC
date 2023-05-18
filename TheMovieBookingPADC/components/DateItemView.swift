//
//  DateItemView.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 18/05/2023.
//

import SwiftUI
struct DateItemView: View {
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            DateBackgroundView()
            
            VStack(spacing:0.0){
                Text("Today")
                    .font(.system(size:MARGIN_MEDIUM_1))
                    .fontWeight(.medium)
                
                Text("May")
                    .font((.system(size: MARGIN_MEDIUM_1)))
                    .fontWeight(.medium)
                    .padding(.top,MARGIN_MEDIUM)
                
                Text("8")
                    .font(.system(size:MARGIN_MEDIUM_2))
                    .fontWeight(.medium)
                    .padding(.top,MARGIN_SMALL)
                
            }
            .padding(.top,MARGIN_MEDIUM_3)
        }.frame(width: DATE_BACKGROUND_WIDTH,height: DATE_BACKGROUND_HEIGHT)
    }
}

struct DateItemView_Previews: PreviewProvider {
    static var previews: some View {
        DateItemView()
    }
}
