//
//  LoginBtnView.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 06/05/2023.
//

import SwiftUI


struct LoginBtnView: View {
    
    var label:String = ""
    var icon:String = ""
    var color:String = ""
    
    
    
    var body: some View {
        
        
        
        if icon.isEmpty {Text(label).frame(width: LOGIN_BTN_WIDTH,height: LOGIN_BTN_HEIGHT)
                .foregroundColor(Color(PRIMARY_COLOR))
                .background(Color(color))
            .cornerRadius(LOGIN_BTN_CONOR_RADIUS) } else {
                Label(label,image : icon ).frame(width: LOGIN_BTN_WIDTH,height: LOGIN_BTN_HEIGHT)
                    .foregroundColor(Color(PRIMARY_COLOR))
                    .background(Color(color))
                    .cornerRadius(LOGIN_BTN_CONOR_RADIUS)
            }
        
        
    }
}


struct LoginBtnView_Preview : PreviewProvider {
    static var previews: some View{
        LoginBtnView(label: "Test",color: BTN_COLOR)
    }
}
