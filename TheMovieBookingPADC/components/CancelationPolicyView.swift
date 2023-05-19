//
//  CancelationPolicyView.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 19/05/2023.
//

import SwiftUI

struct CancelationPolicyView: View {
    @Binding var showPopup:Bool
    var body: some View {
        ZStack{
            Color.black
            VStack(alignment: .leading,spacing: 0.0){
                //title
                Text(LABEL_TICKET_CANCELATION_POLICY_TITLE)
                    .foregroundColor(.white)
                    .font(.system(size: MARGIN_MEDIUM_1))
                    .fontWeight(.semibold)
                    .padding(.bottom,MARGIN_LARGE)
                  
                
                //F&B refund
                FAndBRefundView()
                    .padding(.bottom,MARGIN_LARGE)
                 
                //ticket refund
                TicketRefundAndRulesView()
                    .padding(.bottom,MARGIN_XLARGE_2)
                   
                
                //refund rules
                RefundRulesView()
                    .padding(.bottom,MARGIN_XLARGE)
                    
                
                //btn
                    LoginBtnView(label: LABEL_CLOSE,color: BTN_COLOR)
                        .onTapGesture {
                            showPopup.toggle()
                        }
                        .padding(.leading,MARGIN_MEDIUM)
          
                
               
                    
                
                
               
                
            }.padding([.leading,.trailing],MARGIN_CARD_MEDIUM_2)
               // .padding([.top,.bottom],MARGIN_MEDIUM_2)
            
        }
       
        .cornerRadius(15)
        .background(.black)
        
        .overlay(RoundedRectangle(cornerRadius: CORNER_RADIUS_LARGE)
            .stroke(Color(BTN_COLOR), lineWidth:1))
       
        
     
       
       
    }
}

struct CancelationPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        CancelationPolicyView(showPopup: .constant(false))
    }
}

struct FAndBRefundView: View {
    var body: some View {
        HStack{
            
            Image(IC_SNACK_ICON_LIGHT)
                .resizable()
                .frame(width: MARGIN_LARGE_1,height: MARGIN_LARGE)
            
            Text(LABEL_REFUND_FANDB)
                .foregroundColor(.white)
                .font(.system(size:MARGIN_MEDIUM_2))
                .fontWeight(.bold)
            
            
        }
    }
}

struct TicketRefundAndRulesView: View {
    var body: some View {
        VStack (alignment: .leading,spacing: MARGIN_MEDIUM_3){
            
            //refund title
            HStack(alignment: .top){
                Image(IC_TICKET_REFUND)
                    . resizable()
                    .frame(width: MARGIN_LARGE_1,height: MARGIN_LARGE)
                Text(LABEL_REFUND_TICKET)
                    .foregroundColor(.white)
                    .font(.system(size:MARGIN_MEDIUM_2))
                    .fontWeight(.bold)
            }
            
            //rules
            Text(LABEL_REFUND_TICKET_RULE_1)
                .foregroundColor(Color(LABEL_COLOR))
                .font(.system(size:MARGIN_MEDIUM_1))
                .fontWeight(.bold)
                .padding(.leading,MARGIN_XLARGE_2)
            
            Text(LABEL_REFUND_TICKET_RULE_2)
                .foregroundColor(Color(LABEL_COLOR))
                .font(.system(size:MARGIN_MEDIUM_1))
                .fontWeight(.bold)
                .padding(.leading,MARGIN_XLARGE_2)
            
        }
    }
}

struct RefundRulesView: View {
    var body: some View {
        VStack(alignment:.leading, spacing:MARGIN_MEDIUM_3) {
            Text(LABEL_REFUND_RULE_1)
                .foregroundColor(.white)
                .font(.system(size: MARGIN_MEDIUM_1))
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
            
            Text(LABEL_REFUND_RULE_2)
                .foregroundColor(.white)
                .font(.system(size: MARGIN_MEDIUM_1))
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
        }
    }
}
