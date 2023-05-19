//
//  TicketConfirmationScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 20/05/2023.
//

import SwiftUI

struct TicketConfirmationScreen: View {
    @State var showPopup: Bool = true
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.black
                
                VStack(alignment: .center){
                    Spacer()
                    
                    //title
                    Text("Ticket Confirmation")
                        .foregroundColor(.white)
                        .font(.system(size: TEXT_REGULAR_3X))
                        .fontWeight(.bold)
                        .padding(.bottom,MARGIN_XLARGE)
                    
                    //ticket
                    TicketConfirmationTicketView()
                        .padding(.bottom,MARGIN_XXLARGE)
                    
                    
                    //qr and code view
                    QRCodeView()
                        .padding(.bottom,MARGIN_XXLARGE)
                    
                    //btn
                    
                   Text("Done")
                            .frame(width: 176,height: 40)
                            .background(Color(BTN_COLOR))
                            .cornerRadius(CORNER_RADIUS_SMALL)
                            .onTapGesture {
                                NavigationUtil.popToRootView()
                            }
                    
                    Spacer()
                }
            }.edgesIgnoringSafeArea(.all)
                .background(.black)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                
                        self.showPopup = false
                            }
                
                }
                .overlay {
                    if showPopup{
                        
                        //overlay
                        SuccessOverlay()
                    }
                }
        }.navigationBarBackButtonHidden(true)
    }
}

struct TicketConfirmationScreen_Previews: PreviewProvider {
    static var previews: some View {
        TicketConfirmationScreen(showPopup: true)
    }
}

struct TicketConfirmationMovieInfoView: View {
    var body: some View {
        HStack(alignment:.top,spacing:MARGIN_MEDIUM_3){
            Image("Movie")
                .resizable()
                .frame(width: 120,height: 150)
                .clipped()
            
            
            VStack(alignment:.leading){
                
                //movie title
                HStack{
                    Text("Venom")
                        .foregroundColor(.white)
                        .font(.system(size:MARGIN_MEDIUM_2))
                        .fontWeight(.bold)
                    Text("(3D)(UA)")
                        .foregroundColor(.white)
                        .font(.system(size:MARGIN_MEDIUM_2))
                }.padding(.bottom,MARGIN_CARD_MEDIUM)
                
                //cinema name
                Text("JCGV : Junction City")
                    .foregroundColor(Color(BTN_COLOR))
                    .font(.system(size:MARGIN_MEDIUM_2))
                    .padding(.bottom,MARGIN_MEDIUM_2)
                
                //ticket type and count
                HStack(spacing:0){
                    //ticket type
                    Text("M-Ticket")
                        .foregroundColor(Color(LABEL_COLOR))
                        .font(.system(size: MARGIN_MEDIUM_1))
                        .fontWeight(.semibold)
                    
                    Text("(")
                        .foregroundColor(Color(LABEL_COLOR))
                        .font(.system(size: MARGIN_MEDIUM_1))
                        .fontWeight(.semibold)
                    
                    //ticket count
                    Text("2")
                        .foregroundColor(Color(BTN_COLOR))
                        .font(.system(size: MARGIN_MEDIUM_1))
                        .fontWeight(.semibold)
                    
                    Text(")")
                        .foregroundColor(Color(LABEL_COLOR))
                        .font(.system(size: MARGIN_MEDIUM_1))
                        .fontWeight(.semibold)
                    
                    Spacer()
                }.padding(.bottom,MARGIN_CARD_MEDIUM)
                
                
                //ticket type and number
                HStack(spacing:0){
                    Text("Gold-G8,G7")
                        .foregroundColor(.white)
                        .font(.system(size:MARGIN_MEDIUM_2))
                        .fontWeight(.bold)
                    Text("(Screen 2)")
                        .foregroundColor(Color(LABEL_COLOR))
                        .font(.system(size:MARGIN_MEDIUM_2))
                }
                
                
            }
            
        }
    }
}

struct TicketConfirmationDateTImeLocation: View {
    var body: some View {
        HStack(alignment:.firstTextBaseline){
            
            //date
            VStack{
                Image(IC_CALENDER)
                    .resizable()
                    .frame(width: MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
                Text("Sat, 18 Jun, 2022")
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_1))
                
            }
            
            //spacer
            Spacer()
            
            //time
            VStack{
                Image(systemName: IC_CLOCK)
                
                    .resizable()
                    .frame(width: MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
                    .foregroundColor(Color(BTN_COLOR))
                Text("3:30PM")
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_1))
                
            }
            
            //spacer
            Spacer()
            
            //location
            VStack{
                Image(systemName: IC_LOCATION)
                    .resizable()
                    .frame(width: MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
                    .foregroundColor(Color(BTN_COLOR))
                
                Text("Q5H3+JPP, Corner \nof, Bogyoke Lann, Yangon ")
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_1))
                    .multilineTextAlignment(.center)
                
            }
            
        }
    }
}

struct TicketConfirmationTicketView: View {
    var body: some View {
        VStack{
            //movie info
            TicketConfirmationMovieInfoView()
            
            //cemicircle and dotted line
            CemiCircleAndDottedLineView()
            
            //date time and location
            TicketConfirmationDateTImeLocation()
            
        }.padding([.leading,.trailing],MARGIN_MEDIUM_1)
            .padding([.top,.bottom],MARGIN_XLARGE
            )
            .background(TicketBackgroundGradient()
            )
            .cornerRadius(CORNER_RADIUS_MEDIUM)
            .padding([.leading,.trailing],MARGIN_MEDIUM_1)
    }
}

struct QRCodeView: View {
    var body: some View {
        VStack {
            
            //qr img
            Image("qr")
                .resizable()
                .frame(width: MARGIN_XLLARGE,height: MARGIN_XLLARGE)
            
            //code
            Text("WAG5LP1C")
                .foregroundColor(.white)
                .fontWeight(.bold)
            
            //TPIN
            HStack{
                
                Text("TPIN :")
                    .foregroundColor(Color(LABEL_COLOR))
                    .fontWeight(.bold)
                
                
                Text("WKCSL96")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
        }
    }
}

struct SuccessOverlay: View {
    var body: some View {
        withAnimation {
            ZStack{
                
                Image("ic_success")
                
                
            } .frame(width: UIScreen.main.bounds.width ,height: UIScreen.main.bounds.height)
                .background(.black.opacity(0.9))
        }
    }
}
