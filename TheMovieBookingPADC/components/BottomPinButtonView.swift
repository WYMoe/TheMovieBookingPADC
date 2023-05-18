//
//  BottomPinButtonView.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 18/05/2023.
//

import SwiftUI

struct BottomPinButtonView: View {
    var label:String = ""
   
    var body: some View {
        
        
        //zstack
        ZStack{
           
            //btn with semi circle
            BtnWithSemiCircleView(label: label)
           

        }.frame(width: UIScreen.main.bounds.width,height: MARGIN_XXXLARGE)
            .background(
                
                //gradient
                LinearGradient(gradient:Gradient(colors:[.clear,.black.opacity(0.8),.black]), startPoint: .top, endPoint: .bottom))
    }
}


struct BtnWithSemiCircleView: View {
    var label:String = ""
    var body: some View {
        HStack(alignment:.center){
            //circle
            Circle()
                .trim(from: 0,to: 0.5)
                .fill(Color(PRIMARY_COLOR))
                .frame(width: MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
                .rotationEffect(.degrees(270))
                .offset(x:-10)
            
            Spacer()
            
            //label
            Text(label)
                .foregroundColor(Color(PRIMARY_COLOR))
                .fontWeight(.bold)
            
            
            Spacer()
            
            
            //circle
            Circle()
                .trim(from: 0,to: 0.5)
                .fill(Color(PRIMARY_COLOR))
                .frame(width: MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
                .rotationEffect(.degrees(90))
                .offset(x:10)
            
            
            
            
        }
        .frame(width: BOOKING_BTN_HEIGHT,height: MARGIN_XXLARGE)
        .background(Color(BTN_COLOR))
        .cornerRadius(CORNER_RADIUS_SMALL)
    }
}


struct BottomPinButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BottomPinButtonView()
    }
}
