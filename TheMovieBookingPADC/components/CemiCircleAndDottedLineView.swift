//
//  CemiCircleAndDottedLineView.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 20/05/2023.
//

import SwiftUI

struct CemiCircleAndDottedLineView: View {
    var body: some View {
        ZStack{
            HStack(){
                
                //circle
                Circle()
                    .trim(from: 0,to: 0.5)
                    .rotationEffect(.degrees(270))
                    .frame(width: MARGIN_XXLARGE)
                    .foregroundColor(Color(.black))
                
                
                
                    .offset(x:-MARGIN_XLARGE_2)
                //spacer
                Spacer()
                
                //circle
                Circle()
                    .trim(from: 0,to: 0.5)
                    .rotationEffect(.degrees(90))
                    .frame(width: MARGIN_XXLARGE)
                    .offset(x:MARGIN_XLARGE_2)
                    .foregroundColor(Color(.black))
                
            }
            
            //dotted line
            Line()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [8]))
                .frame(height: 1)
                .foregroundColor(Color(.gray))
                .padding()
        }
        .padding(.top,MARGIN_MEDIUM_2)
    }
}

struct CemiCircleAndDottedLineView_Previews: PreviewProvider {
    static var previews: some View {
        CemiCircleAndDottedLineView()
    }
}
