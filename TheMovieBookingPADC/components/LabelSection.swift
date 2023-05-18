//
//  LabelSection.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 07/05/2023.
//

import SwiftUI

struct LabelSection: View {
    var label1:String = ""
    var label2:String = ""
    var body: some View {
        Group{
            //label
            Text(label1)
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size:TEXT_REGULAR_3X))
            
            //label
            Text(label2)
                .foregroundColor(Color(LABEL_COLOR))
                .multilineTextAlignment(.center)
                .padding(.bottom,MARGIN_XXXLARGE)
        }
    }
}

struct LabelSection_Previews: PreviewProvider {
    static var previews: some View {
        LabelSection(label1:"",label2: "")
    }
}
