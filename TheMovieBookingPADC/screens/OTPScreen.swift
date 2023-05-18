//
//  OTPScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 06/05/2023.
//

import SwiftUI

struct OTPScreen: View {
    
    
    @State var otp:String
    
    @FocusState var isKeyboardShowing: Bool
    
    init(otp: String, isKeyboardShowing: Bool) {
        self.otp = otp
        self.isKeyboardShowing = isKeyboardShowing
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color(PRIMARY_COLOR)
                VStack(spacing: 0.0) {
                    //logo
                    Image(IC_LOGO)
                        .padding(.bottom,MARGIN_XXXLARGE)
                    
                    
                    //label section
                    LabelSection(label1: LABEL_SENT_OTP,label2: LABEL_ENTER_OTP)
        
                    
                    //OTP Section
                    OTPSection(otp: $otp,isKeyboardShowing: $isKeyboardShowing)
                    
                    //Resend Code
                    ResendCodeView()
                    
                    
                    //Confirm btn
                    NavigationLink {
                       RegionScreen(locationText: "")
                    }label: {
                        LoginBtnView(label: LABEL_CONFIRM_OTP,color: BTN_COLOR)
                    }
                    
                    
                    
                    
                    
                }.toolbar {
                    ToolbarItem(placement:.keyboard) {
                      
                    
                            Button(LABEL_DONE){
                                isKeyboardShowing.toggle()
                            }
                            .frame(maxWidth: .infinity,alignment: .trailing)
                        
                      
                    }
                }
            }.edgesIgnoringSafeArea([.top,.bottom])
        }
    }
}

struct OTPScreen_Previews: PreviewProvider {
    static var previews: some View {
        OTPScreen(otp: "", isKeyboardShowing: false)
    }
}

//struct OTPTextField: View {
//   @Binding var otp:String
//    var body: some View {
//        TextField("",text: $otp)
//            .padding(.all)
//            .frame(width: 50,  height: 50)
//            .background(Color(PRIMAYR_LIGHT_COLOR))
//            .cornerRadius(5)
//            .onChange(of: otp) { _ in
//                otp = String(otp.prefix(1))
//            }
//    }
//}


struct OTPTextField: View {
    var index: Int = 0
  @Binding var otp:String
    var body: some View {
        
        ZStack{
            if otp.count > index {
                let charIndex = otp.index(otp.startIndex, offsetBy: index)
                let charOtp = String(otp[charIndex])
               
                Text(charOtp)
                    .foregroundColor(Color(PRIMARY_COLOR))
            }else{
                Text("")
            }
        }
            .padding(.all)
            .frame(width: MARGIN_XXLARGE ,  height: MARGIN_XXLARGE)
            .background(Color(PRIMARY_LIGHT_COLOR))
            .cornerRadius(OTP_TEXTFIELD_CORNER_RADIUS)
            
    }
}



struct OTPTextFieldRow: View {
    @Binding var otp:String
    
    var isKeyboardShowing:FocusState<Bool>.Binding
    
    var body: some View {
        ZStack{
            HStack{
                ForEach(0..<6,id:\.self){
                    
                    index in
                    OTPTextField(index: index, otp: $otp)
                    
                }
            }
            TextField("",text: $otp)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .foregroundColor(.white)
                .frame(width: 1,height: 1)
                .opacity(0.001)
                .blendMode(.screen)
                .focused(isKeyboardShowing)
            //limitText
                .onChange(of: otp) { _ in
                    otp = String(otp.prefix(OTP_CHAR_LIMIT))
                    
                }
            
            
        }.contentShape(Rectangle())
            .onTapGesture {
                isKeyboardShowing.wrappedValue.toggle()
            }
    }
}



struct OTPSection: View {
    @Binding var otp:String
    
    var isKeyboardShowing:FocusState<Bool>.Binding
    
    var body: some View {
        VStack(alignment:.leading){
            Text(LABEL_OTP_TEXTFIELD)
                .foregroundColor(Color(LABEL_COLOR))
                .font(.system(size: TEXT_REGULAR))
            
            
            OTPTextFieldRow(otp: $otp,isKeyboardShowing: isKeyboardShowing)
                .padding(.bottom,MARGIN_XLARGE_2)
        }
    }
}

struct ResendCodeView: View {
    var body: some View {
        HStack{
            
            Text(LABEL_DONT_RECEIVE)
                .foregroundColor(Color(LABEL_COLOR))
                .font(.system(size: TEXT_REGULAR))
            Button(LABEL_RESEND){
                
            }.foregroundColor(Color(BTN_COLOR))
            
        }.padding(.bottom,MARGIN_XLARGE_2)
    }
}
