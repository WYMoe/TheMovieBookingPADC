//
//  PaymentScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 19/05/2023.
//

import SwiftUI

struct PaymentScreen: View {
    @State  var nameText:String = ""
    @Environment(\.presentationMode) var presentation
    var body: some View {
        NavigationStack {
            ZStack{
                Color.black
                
                VStack(spacing:0.0){
                    
                    //appbar
                    PaymentScreenAppbarView(){
                        presentation.wrappedValue.dismiss()
                    }
                        .padding(.bottom,MARGIN_XLARGE_1)
                    
                    //textfield
                    TextFielNameView(nameText: $nameText)
                        .padding(.bottom,MARGIN_XLARGE)
                    
                    //btn
                    NavigationLink{
                        TicketConfirmationScreen(showPopup: true)
                    } label:{
                        ApplyPromocodeBtnView()
                            .padding(.bottom,MARGIN_XLARGE_1)
                    }
                    
                    VStack(alignment: .leading){
                        Text(LABEL_CHOOSE_PAYMENT)
                            .foregroundColor(Color(BTN_COLOR))
                            .font(.system(size: TEXT_REGULAR_2X))
                            .fontWeight(.bold)
                            .padding(.bottom,MARGIN_MEDIUM_3)
                        
                   //payment types
                        PaymentTypeItemView(icon: IC_UPI,label: LABEL_UPI)
                        PaymentTypeItemView(icon: IC_GIFT,label: LABEL_GIFTVOCHER)
                        PaymentTypeItemView(icon: IC_PAY,label: LABEL_QUICK_PAY)
                        PaymentTypeItemView(icon: IC_CARD,label: LABEL_CARD)
                        PaymentTypeItemView(icon: IC_POINT,label: LABEL_POINT)
                        PaymentTypeItemView(icon: IC_WALLET,label: LABEL_WALLET)
                        PaymentTypeItemView(icon: IC_BANKING,label: LABEL_BANKING)
                              
                        
                            
                        
                    }
                    
                    
                }.padding([.leading,.trailing],MARGIN_MEDIUM_3)
                
            }.edgesIgnoringSafeArea(.all)
        }.navigationBarBackButtonHidden(true)
    }
}

struct PaymentScreen_Previews: PreviewProvider {
    static var previews: some View {
        PaymentScreen()
    }
}

struct PaymentScreenAppbarView: View {
    var onTapBack:()->Void = {
        
    }
    var body: some View {
        HStack{
            
            //IC_BACK
            Image(systemName: IC_BACK)
                .resizable()
                .frame(width: MARGIN_CARD_MEDIUM_2,height: MARGIN_MEDIUM_3)
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .onTapGesture {
                     onTapBack()
                }
            
            Spacer()
            
            //checkout
            Text(LABEL_PAYMENT)
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_3))
                .fontWeight(.bold)
            Spacer()
            
        }
    }
}

struct PaymentTextFieldOverlay: View {
    var body: some View {
        ZStack(alignment: .topLeading){
            RoundedRectangle(cornerRadius: CORNER_RADIUS_MEDIUM)
                .stroke(Color(BTN_COLOR), lineWidth:1)
            
            Text("Your Name")
                .padding(MARGIN_SMALL)
                .foregroundColor(Color(BTN_COLOR))
                .font(.system(size: MARGIN_MEDIUM_1))
                .background(.black)
                .offset(x:MARGIN_MEDIUM_3,y: -MARGIN_MEDIUM_1)
            
        }.frame(width: 330,height: 60)
    }
}

struct TextFielNameView: View {
    @Binding var nameText:String
    var body: some View {
        HStack{
            ZStack {
                //textfield border
                PaymentTextFieldOverlay()
                
                //textfield
                TextField(text: $nameText,prompt: Text(LABEL_ENTER_NAME).foregroundColor(Color(LABEL_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_1))) {
                        
                    }.padding(.leading,MARGIN_LARGE_1)
                    .foregroundColor(.white)
            }
            //star
            Text("*")
                .foregroundColor(.red)
            
        }
    }
}

struct ApplyPromocodeBtnView: View {
    var body: some View {
        HStack{
            Image(IC_PAYMENT_BTN_ICON)
            Text(LABEL_PAYMENT_BTN)
                .font(.system(size: MARGIN_MEDIUM_1))
        }
        .frame(width: 330,height: LOGIN_BTN_HEIGHT)
        
        .foregroundColor(Color(PRIMARY_COLOR))
        .fontWeight(.semibold)
        .background(Color(BTN_COLOR))
        .cornerRadius(LOGIN_BTN_CONOR_RADIUS)
        .padding(.trailing,12)
    }
}

struct PaymentTypeItemView: View {
    
    var icon:String = ""
    var label:String = ""
    var body: some View {
        
        HStack{
            Image(icon)
                .resizable()
                .frame(width: MARGIN_XLARGE,height: MARGIN_XLARGE)
            
            Text(label)
                .foregroundColor(.white)
                .font(.system(size: TEXT_REGULAR))
                .fontWeight(.semibold)
            Spacer()
            Image(systemName:IC_NEXT)
                .foregroundColor(.white)
            
            
                
        }
        .padding([.leading,.trailing],MARGIN_MEDIUM)
        .padding([.top,.bottom],MARGIN_CARD_MEDIUM)
            .overlay{
                RoundedRectangle(cornerRadius: CORNER_RADIUS_MEDIUM)
                    .stroke(Color(PRIMARY_DARK_COLOR), lineWidth:1)
                    .frame(width: 367,height: 50)
                   
            }
    }
}
