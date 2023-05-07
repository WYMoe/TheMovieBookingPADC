//
//  LoginScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 05/05/2023.
//

import SwiftUI

struct LoginScreen: View {
    @State var showOTP:Bool

    var body: some View {
        
            ZStack{
                Color.black
                VStack(spacing:0.0){
                    
                    
                    //logo
                    Image(IC_LOGO)
                        .padding(.bottom,MARGIN_XXXLARGE)
                    
                    //label section
                    LabelSection(label1: LABEL_VERIFY,label2: LABEL_WILL_SEND_DIGITS)
                        
                        //countrycode and ph number
                        CountryCodeAndPhNumberView().padding(EdgeInsets(top: 0, leading: MARGIN_XLARGE, bottom: MARGIN_XXLARGE, trailing: MARGIN_XLARGE))
                        
                        
                        //btn verify
                        
                        NavigationLink(value: "") {
                            LoginBtnView(label: LABEL_VERIFY,color: BTN_COLOR)
                                .padding(.bottom,MARGIN_XLARGE)
                        }.navigationDestination(for: String.self) { _ in
                            OTPScreen(otp: "", isKeyboardShowing: false)
                        }
                        
                        //divider
                        DividerView().padding(.bottom,MARGIN_LARGE)
                        
                        //btn google
                        
                        LoginBtnView(label: LABEL_CONTINUE_WITH_GOOGLE,icon: IC_GOOGLE,color: PRIMAYR_LIGHT_COLOR)
                            .padding(.bottom,MARGIN_XXXLARGE)
                        
                        //terms and condition
                        Text(LABEL_TERMS_AND_CONDITIONS)
                            .foregroundColor(Color(LABEL_COLOR))
                            .font(.system(size: TEXT_SMALL))
                    
                    
                    
                    
                    
                }
            }.edgesIgnoringSafeArea([.top,.bottom])
        
        
       
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(showOTP: false)
    }
}


struct DividerView: View {
    var body: some View {
        HStack{

            Rectangle()
                .frame(width: DIVIDER_WIDTH,height: 1)
                .foregroundColor(Color(LABEL_COLOR))
                .padding([.leading,.trailing],MARGIN_MEDIUM_3)

            Text("or")
                .foregroundColor(Color(PRIMAYR_LIGHT_COLOR))

            Rectangle()
                .frame(width: DIVIDER_WIDTH,height: 1)
                .foregroundColor(Color(LABEL_COLOR))
                .padding([.leading,.trailing],MARGIN_MEDIUM_3)

        }
    }
}


