//
//  CountryCodeView.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 05/05/2023.
//

import SwiftUI

struct CountryCodeAndPhNumberView: View {
    @State private var countryCode = "+95"
    @State private var phoneNumber = ""
    
    @FocusState var isKeyboardShowing: Bool

    
    let countryCodes = [ "+2","+3","+4","+1", "+44", "+91", "+86"]
    var body: some View {
        HStack(alignment:.bottom) {
            
            VStack(spacing: 10){
                
                Text(LABEL_COUNTRY_CODE)
                    .foregroundColor(Color(LABEL_COLOR))
                
                HStack(spacing:50){
                    Text(countryCode)
                      .foregroundColor(Color(PRIMAYR_LIGHT_COLOR))

                    Menu {
                        ForEach(countryCodes,id: \.self){ code in
                            Button("\(code)"){
                                countryCode = code
                            }
                            
                        }
                           } label: {
                               Image(systemName: IC_DROPDOWN)
                                   .foregroundColor(Color(LABEL_COLOR))
                           }

                }
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width:COUNTRY_CODE_UNDERLINE_WIDTH ,height: 1)
                    
            }
           
            Spacer()
            VStack(spacing:10){
                
                ZStack(alignment:.leading){
                    if phoneNumber.isEmpty {
                        Text(LABEL_MOBILE_NUMBER)
                            .foregroundColor(Color(LABEL_COLOR))
                    }
                    TextField("", text:$phoneNumber)
                        .foregroundColor(Color(PRIMAYR_LIGHT_COLOR))
                        .keyboardType(.phonePad)
                        .focused($isKeyboardShowing)
                }
              
                    
                Rectangle()
                    .foregroundColor(Color(PRIMAYR_LIGHT_COLOR))
                    .frame(width:PH_NUMBER_UNDERLINE_WIDTH ,height: 1)
            }
        } .toolbar {
            ToolbarItem(placement:.keyboard) {
              
            
                    Button(LABEL_DONE){
                        isKeyboardShowing.toggle()
                    }
                    .frame(maxWidth: .infinity,alignment: .trailing)
                
              
            }
        }
    }
}




struct CountryCodeAndPhNumberView_Previews: PreviewProvider {
    static var previews: some View {
        CountryCodeAndPhNumberView()
    }
}



