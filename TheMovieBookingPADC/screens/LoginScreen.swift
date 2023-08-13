//
//  LoginScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 05/05/2023.
//

import SwiftUI

struct LoginScreen: View {
   
    @State var screenSelection:String? = nil
    @State var isPresented : Bool = false
    @State var phoneNumber : String = ""
    
    //data model
    let mBookingModel : MovieBookingModel = MovieBookingModelImpl.shared
    
     @State var otpObj : OTPVO? = nil
    
    var body: some View {
        
        NavigationStack {
            ZStack{
                Color(PRIMARY_COLOR)
                VStack(spacing:0.0){
                    
                    
                    //logo
                    Image(IC_LOGO)
                        .padding(.bottom,MARGIN_XXXLARGE)
                    
                    //label section
                    LabelSection(label1: LABEL_VERIFY,label2: LABEL_WILL_SEND_DIGITS)
                    
                    //countrycode and ph number
                    CountryCodeAndPhNumberView(phoneNumber: $phoneNumber).padding(EdgeInsets(top: 0, leading: MARGIN_XLARGE, bottom: MARGIN_XXLARGE, trailing: MARGIN_XLARGE))
                    
                    
                   // btn verify
                    LoginBtnView(label: LABEL_VERIFY,color: BTN_COLOR).padding(.bottom,MARGIN_XLARGE).onTapGesture {
                        
                        mBookingModel.getOTP(phoneNumber: phoneNumber) { otpVO in
                            print("login screen : \(otpVO.message ?? "")")
                            if otpVO.message == "Otp sent" {
                                isPresented = true
                                
                            }
                        } onFailure: { error in
                            
                        }


                    }
                    
               
                   
                    //divider
                    DividerView().padding(.bottom,MARGIN_LARGE)
                    
                    //btn google
                    NavigationLink{
                        
                    }label: {
                        LoginBtnView(label: LABEL_CONTINUE_WITH_GOOGLE,icon: IC_GOOGLE,color: PRIMARY_LIGHT_COLOR)
                            .padding(.bottom,MARGIN_XXXLARGE)
                           
                    }
                    
                    
                    //terms and condition
                    Text(LABEL_TERMS_AND_CONDITIONS)
                        .foregroundColor(Color(LABEL_COLOR))
                        .font(.system(size: TEXT_SMALL))
                    
                    
                    
                    
                    
                }
            }.edgesIgnoringSafeArea([.top,.bottom])
                
                .navigationDestination(isPresented: $isPresented) {
                   OTPScreen(phoneNumber: phoneNumber)
                }
            
          
        }
       
    }
    
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
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
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
            
            Rectangle()
                .frame(width: DIVIDER_WIDTH,height: 1)
                .foregroundColor(Color(LABEL_COLOR))
                .padding([.leading,.trailing],MARGIN_MEDIUM_3)
            
        }
    }
}


