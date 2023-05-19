//
//  CheckOutScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 16/05/2023.
//

import SwiftUI

struct CheckOutScreen: View {
    @State var isSnacksShowing:Bool = true
    @State var isCancelPolicyShowing:Bool = true
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        //navigation stack
        NavigationStack {
            
            //zstack
            ZStack{
                Color(.black)
                
                // vstack
                VStack(alignment:.center,spacing: 0.0) {
                    
                    //appbar
                    CheckoutScreenAppbarView(){
                        dismiss()
                    }
                    
                    //ticket section
                    TicketSection(isSnacksShowing: $isSnacksShowing)
                    
                }
                .safeAreaInset(edge: .bottom) {
                    
                    //btn
                    BottomPinButtonView(label: "Continue")
                }
                .padding(.top,MARGIN_MEDIUM_3)
            }
            .edgesIgnoringSafeArea([.top
                                    ,.bottom])
        }.navigationBarBackButtonHidden(true)
    }
}

struct CheckOutScreen_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutScreen()
    }
}

struct MovieTitleAndCinemaNameSection: View {
    var body: some View {
        //vstack
        VStack(alignment:.leading, spacing:10.0){
            
            //hstack
            HStack {
                
                //movie title
                Text("Black Widow")
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .fontWeight(.bold)
                //type
                Text("(3D)")
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_2))
                //rating
                Text("(U/A)")
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_2))
                
                
            }
            
            //hstack
            HStack{
                //cinema name
                Text("JCGV :Junction City")
                    .foregroundColor(Color(BTN_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_2))
                //cinema number
                Text("(SCREEN 2)")
                    .foregroundColor(Color(CHECKOUT_TICKET_TEXT_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_2))
                
                
            }
        }
        .padding(.bottom,MARGIN_MEDIUM_3)
    }
}

struct DateTimeAndLocationSection: View {
    var body: some View {
        
        //hstack
        HStack(alignment:.firstTextBaseline){
            
            //date
            VStack{
                Image(IC_CALENDER)
                    .resizable()
                    .frame(width: MARGIN_MEDIUM_1,height: MARGIN_MEDIUM_1)
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
                    .frame(width: MARGIN_MEDIUM_1,height: MARGIN_MEDIUM_1)
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
                    .frame(width: MARGIN_MEDIUM_1,height: MARGIN_MEDIUM_1)
                    .foregroundColor(Color(BTN_COLOR))
                
                Text("Q5H3+JPP, Corner of, Bogyoke Lann, Yangon ")
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_1))
                    .multilineTextAlignment(.center)
                
            }
          
        }
    }
}



struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct CheckoutScreenAppbarView: View {
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
            Text("Checkout")
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_3))
                .fontWeight(.bold)
            Spacer()
            
        }.padding([.leading,.trailing],MARGIN_MEDIUM_3)
            .padding(.bottom,MARGIN_XLARGE_2)
    }
}

struct TicketTypeAndCountView: View {
    var body: some View {
        HStack{
            //ticket type
            Text("M-Ticket")
                .foregroundColor(Color(CHECKOUT_TICKET_TEXT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_1))
            Text("(")
                .foregroundColor(Color(CHECKOUT_TICKET_TEXT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_1))
            
            //ticket count
            Text("2")
                .foregroundColor(Color(BTN_COLOR))
                .font(.system(size: MARGIN_MEDIUM_1))
            
            Text(")")
                .foregroundColor(Color(CHECKOUT_TICKET_TEXT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_1))
            Spacer()
        }
    }
}

struct SeatNumberAndPriceView: View {
    var body: some View {
        HStack{
            Text("Gold-G8,G7")
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_2))
                .fontWeight(.medium)
            Spacer()
            Text("20000Ks")
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_2))
                .fontWeight(.medium)
        }
    }
}

struct FoodAndBeverageView: View {
    @Binding var isSnacksShowing:Bool
    var body: some View {
        HStack{
            
            //icon
            Image(IC_SNACK_ICON_LIGHT)
                .resizable()
                .frame(width: MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
            //label
            Text("Food and Beverage")
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_3))
                .fontWeight(.medium)
            
            //btn
            Image(systemName: isSnacksShowing ? IC_DROPUP : IC_DROPDOWN)
                .resizable()
                .frame(width: MARGIN_CARD_MEDIUM_2,height:MARGIN_MEDIUM)
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .onTapGesture {
                    isSnacksShowing.toggle()
                }
            //spacer
            Spacer()
            //price
            Text("2000Ks")
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_2))
                .fontWeight(.medium)
        }
    }
}

struct SnackListItem: View {
    var body: some View {
        HStack{
            
            //icon
            Image(IC_CANCEL)
                .resizable()
                .frame(width: MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
            //snack name and qt
            Text("Potatoe Chips (Qt. 1)")
                .foregroundColor(Color(CHECKOUT_TICKET_TEXT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_1))
            Spacer()
            //price
            Text("1000Ks")
                .foregroundColor(Color(CHECKOUT_TICKET_TEXT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_1))
            
            
            
        }
    }
}

struct TicketDivider: View {
    
    var body: some View {
        Rectangle()
            .frame(height: 0.5)
            .foregroundColor(Color(CHECKOUT_TICKET_TEXT_COLOR))
            
    }
}

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

struct TicketBackgroundGradient: View {
    var body: some View {
        LinearGradient(
            colors: [Color(CHECKOUT_TICKET_BG1),Color(CHECKOUT_TICKET_BG2),Color(CHECKOUT_TICKET_BG3),Color(CHECKOUT_TICKET_BG2),Color(CHECKOUT_TICKET_BG1)],
            
            startPoint: .top, endPoint: .bottom)
    }
}

struct TicketTopSection: View {
    @Binding var isSnacksShowing:Bool
    var body: some View {
        Group{
            //title
            MovieTitleAndCinemaNameSection()
            
            //date time loctation
            DateTimeAndLocationSection()
            
            //ticket type and count
            TicketTypeAndCountView()
            
            //seat number and Price
            SeatNumberAndPriceView()
            
            //divider
            TicketDivider()
            
            //food and beverage
            FoodAndBeverageView(isSnacksShowing: $isSnacksShowing)
            
            
            //snack list
            if isSnacksShowing {
                ForEach(1...2,id:\.self){
                    _ in
                    
                    //item
                    SnackListItem()
                }
            }
        }.padding(.bottom,MARGIN_MEDIUM)
    }
}

struct TicketBottomSection: View {
    var body: some View {
        Group{
            //convenient fee
            HStack{
                
                //label
                Text(LABEL_CONVINENCE_FEE)
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .fontWeight(.medium)
                
                
                //btn
                Image(systemName: IC_DROPDOWN)
                    .resizable()
                    .frame(width: MARGIN_CARD_MEDIUM_2,height:MARGIN_MEDIUM)
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                
                //spacer
                Spacer()
                
                
                //price
                Text("500Ks")
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .fontWeight(.medium)
            }
            
            // cancelation policy
            HStack{
                HStack{
                    Image(systemName: IC_WARNING)
                        .foregroundColor(Color(PRIMARY_LIGHT_COLOR
                                              ))
                    Text(LABEL_CANCEL_POLICY)
                        .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                        .font(.system(size: MARGIN_MEDIUM_1))
                        .foregroundColor(Color(PRIMARY_DARK_COLOR))
                    
                    
                }
                .padding(MARGIN_SMALL+1)
                .background(Color(CANCEL_POLICY_BG))
                .cornerRadius(MARGIN_MEDIUM_2)
                Spacer()
            }.padding(.bottom,20)
            
            
            //divider
            TicketDivider()
            
            //total
            HStack{
                Text(LABEL_TOTAL)
                    .foregroundColor(Color(BTN_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_3))
                    .fontWeight(.bold)
                Spacer()
                Text("22500Ks")
                    .foregroundColor(Color(BTN_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_3))
                    .fontWeight(.bold)
                
            }.padding(.top,MARGIN_MEDIUM_3)
            
            
            
            
        }
    }
}

struct TicketSection: View {
    @Binding var isSnacksShowing:Bool
    var body: some View {
        VStack(alignment:.leading,spacing: MARGIN_MEDIUM) {
            
            
            
            
            //ticket top section
            TicketTopSection(isSnacksShowing: $isSnacksShowing)
            
            
            //cemicircle and dotted line
            CemiCircleAndDottedLineView()
            
            //ticker bottom section
            TicketBottomSection()
            
            
            
            
            
        }
        .padding([.leading,.trailing],MARGIN_MEDIUM_1)
        .padding([.top,.bottom],MARGIN_XLARGE
        )
        .background(TicketBackgroundGradient()
        )
        .cornerRadius(CORNER_RADIUS_MEDIUM)
        .padding([.leading,.trailing],MARGIN_MEDIUM_1)
    }
}
