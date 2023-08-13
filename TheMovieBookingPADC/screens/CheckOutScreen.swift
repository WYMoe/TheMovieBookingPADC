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
    @State var showPopup:Bool = false
    @Environment(\.dismiss) var dismiss
    
    //for checkout
    var movieTitle : String
    var movieId : Int
   
    var cinema : String
    var screenStatus : Int
    var selectedDate : String
    var selectedTime : String
    var ticketCountForCheckout : Int
    var seatNamesForCheckout : String
    var ticketsPriceForCheckout : Int
    @Binding var snacksForCheckout : [SnackVO]?
    var timeslotId : Int
    var cityId : Int
    var cityName : String
    @State var formattedDate : String = ""
    
    @State var isPresented : Bool = false
    
    var body: some View {
        
        
    
            
            //background
            ZStack{
                Color(.black)
                
                // body
                VStack(alignment:.center,spacing: 0.0) {
                    
                    //appbar
                    CheckoutScreenAppbarView(){
                        dismiss()
                    }
                    
                    //ticket view
                    TicketView(isSnacksShowing: $isSnacksShowing,showPopup: $showPopup,movieTitle: movieTitle,cinema: cinema,screenStatus: screenStatus,selectedDate: formattedDate,selectedTime: selectedTime,ticketCountForCheckout: ticketCountForCheckout,seatNamesForCheckout:seatNamesForCheckout, ticketsPriceForCheckout: ticketsPriceForCheckout,snacksForCheckout: $snacksForCheckout )
                    
                }
                .safeAreaInset(edge: .bottom) {
                    
                    //continue btn
                    
                    BottomPinButtonView(label: LABEL_CONTINUE)
                        .onTapGesture {
                            isPresented = true
                        }
                        
                }
                .padding(.top,MARGIN_MEDIUM_3)
            }
            .edgesIgnoringSafeArea([.top,.bottom])
            .background(.black)
            .navigationDestination(isPresented: $isPresented, destination: {
                PaymentScreen(cinema_day_timeslot_id: timeslotId, seat_number: seatNamesForCheckout, booking_date:selectedDate , movie_id: movieId, snacksRequest: snacksForCheckout ?? [],snacksforRawdata: [],movieTitle: movieTitle,cinemaName: cinema,status: screenStatus,cityId:cityId,cityName:cityName)
            })
            .navigationBarBackButtonHidden(true)
            .onAppear{
                self.formattedDate = formatDate(inputDate: selectedDate) ?? ""
            }
            .popupNavigationView(horizontalPadding: MARGIN_SMALL,show: $showPopup) {
                CancelationPolicyView(showPopup: $showPopup)
            }
        
    }
    
    func formatDate(inputDate: String) -> String? {
        let inputFormat = DateFormatter()
        inputFormat.dateFormat = "yyyy-M-d"
        
        if let date = inputFormat.date(from: inputDate) {
            let outputFormat = DateFormatter()
            outputFormat.dateFormat = "E, d MMM, yyyy"
            return outputFormat.string(from: date)
        }
        
        return nil
    }
}

//struct CheckOutScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckOutScreen(movieTitle: "", cinema: "", screenStatus: 0,selectedDate: "",selectedTime: "",ticketCountForCheckout: 0,seatNamesForCheckout: "",ticketsPriceForCheckout: 0,snacksForCheckout: nil)
//    }
//}

//appbar
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



//ticekt view
struct TicketView: View {
    @Binding var isSnacksShowing:Bool
    @Binding var showPopup:Bool
    var movieTitle : String
    var cinema : String
    var screenStatus : Int
    var selectedDate : String
    var selectedTime : String
    var ticketCountForCheckout : Int
    var seatNamesForCheckout : String
    var ticketsPriceForCheckout : Int
    @Binding var snacksForCheckout : [SnackVO]?
    
    var snackTotalPrice : Int {
        var t : Int = 0
        snacksForCheckout?.filter({ s in
            s.quantity ?? 0 > 0
        }).forEach({ s in
            t += ((s.quantity ?? 0) * (s.price ?? 0) * 1000)
        })
        return t
    }
    var convinentFee = 500
    
    var body: some View {
        VStack(alignment:.leading,spacing: MARGIN_MEDIUM) {
            
            
            
            
            //ticket top section
            TicketTopSection(isSnacksShowing: $isSnacksShowing,movieTitle: movieTitle,cinema: cinema,screenStatus: screenStatus,selectedDate: selectedDate,selectedTime: selectedTime,ticketCountForCheckout: ticketCountForCheckout,seatNamesForCheckout: seatNamesForCheckout,ticketsPriceForCheckout: ticketsPriceForCheckout,snacksForCheckout: $snacksForCheckout,snackTotalPrice: snackTotalPrice)
            
            
            //cemicircle and dotted line
            CemiCircleAndDottedLineView()
            
            //ticker bottom section
            TicketBottomSection(showPopup: $showPopup,grandTotal: snackTotalPrice+ticketsPriceForCheckout+500,convinentFee: convinentFee)
            
            
            
            
            
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


//ticket top section
struct TicketTopSection: View {
    @Binding var isSnacksShowing:Bool
    var movieTitle : String
    var cinema : String
    var screenStatus : Int
    var selectedDate : String
    var selectedTime : String
    var ticketCountForCheckout : Int
    var seatNamesForCheckout : String
    var ticketsPriceForCheckout : Int
    @Binding var snacksForCheckout : [SnackVO]?
    var dummysnacks : [SnackVO]? = []
    var snackTotalPrice : Int
    var body: some View {
       Group{
            //title
           MovieTitleAndCinemaNameSection(movieTitle: movieTitle, cinema: cinema, screenStatus: screenStatus)
            
            //date time loctation
            DateTimeAndLocationSection(selectedDate: selectedDate, selectedTime: selectedTime)
            
            //ticket type and count
            TicketTypeAndCountView(ticketCountForCheckout: ticketCountForCheckout)
            
            //seat number and Price
            SeatNumberAndPriceView(seatNamesForCheckout: seatNamesForCheckout,ticketsPriceForCheckout: ticketsPriceForCheckout)
            
            //divider
            TicketDivider()
            
            //food and beverage
            FoodAndBeverageView(isSnacksShowing: $isSnacksShowing,totalPrice: snackTotalPrice)
            
            
            //food and beverage list
            if isSnacksShowing {
                ForEach(snacksForCheckout ?? [],id:\.id){
                    snack in

                    if (snack.quantity ?? 0 > 0) {
                        FoodAndBeverageItemView(snack: snack) {
                            let index = snacksForCheckout?.firstIndex(where: { s in
                                snack.id == s.id
                            })
                            
                            snacksForCheckout?[index ?? 0].quantity = 0
                        }
                    }

                }
            }
           
        }.padding(.bottom,MARGIN_MEDIUM)
    }
}

//movie title and cinema name
struct MovieTitleAndCinemaNameSection: View {
    var movieTitle : String
    var cinema : String
    var screenStatus : Int
    var body: some View {
        //vstack
        VStack(alignment:.leading, spacing:10.0){
            
            //hstack
            HStack {
                
                //movie title
                Text(movieTitle)
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
                Text(cinema)
                    .foregroundColor(Color(BTN_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_2))
                //cinema number
                Text("(SCREEN \(screenStatus))")
                    .foregroundColor(Color(CHECKOUT_TICKET_TEXT_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_2))
                
                
            }
        }
        .padding(.bottom,MARGIN_MEDIUM_3)
    }
}



//datetime
struct DateTimeAndLocationSection: View {
    var selectedDate : String
    var selectedTime : String
    var body: some View {
        
        //hstack
        HStack(alignment:.firstTextBaseline){
            
            //date
            VStack{
                Image(IC_CALENDER)
                    .resizable()
                    .frame(width: MARGIN_MEDIUM_1,height: MARGIN_MEDIUM_1)
                Text(selectedDate)
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
                Text(selectedTime)
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


//ticket type and count
struct TicketTypeAndCountView: View {
    var ticketCountForCheckout : Int
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
            Text(String(ticketCountForCheckout))
                .foregroundColor(Color(BTN_COLOR))
                .font(.system(size: MARGIN_MEDIUM_1))
            
            Text(")")
                .foregroundColor(Color(CHECKOUT_TICKET_TEXT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_1))
            Spacer()
        }
    }
}

//seat number and price
struct SeatNumberAndPriceView: View {
    var seatNamesForCheckout : String
    var ticketsPriceForCheckout : Int
    var body: some View {
        HStack{
            Text(seatNamesForCheckout)
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_2))
                .fontWeight(.medium)
            Spacer()
            Text("\(ticketsPriceForCheckout)Ks")
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_2))
                .fontWeight(.medium)
        }
    }
}

//divider
struct TicketDivider: View {
    
    var body: some View {
        Rectangle()
            .frame(height: 0.5)
            .foregroundColor(Color(CHECKOUT_TICKET_TEXT_COLOR))
            
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

//food and beverage
struct FoodAndBeverageView: View {
    @Binding var isSnacksShowing:Bool
    
    var totalPrice : Int
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
            
                Text("\(totalPrice)Ks")
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .fontWeight(.medium)
            
        }
    }
}

//fandb item
struct FoodAndBeverageItemView: View {
    var snack : SnackVO
    var price : Int {
        (snack.quantity ?? 0 ) * ( snack.price ?? 0 ) * 1000
    }
    var onTapCancel : () -> Void
    var body: some View {
        HStack{

            //icon
            Image(IC_CANCEL)
                .resizable()
                .frame(width: MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
                .onTapGesture {
                    onTapCancel()
                }
            //snack name and qt
            Text("\(snack.name ?? "") (Qt. \(String(snack.quantity ?? 0)))")
                .foregroundColor(Color(CHECKOUT_TICKET_TEXT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_1))
            Spacer()
            //price
            Text("\(price)Ks")
                .foregroundColor(Color(CHECKOUT_TICKET_TEXT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_1))



        }
    }
}













//ticket bg gradient
struct TicketBackgroundGradient: View {
    var body: some View {
        LinearGradient(
            colors: [Color(CHECKOUT_TICKET_BG1),Color(CHECKOUT_TICKET_BG2),Color(CHECKOUT_TICKET_BG3),Color(CHECKOUT_TICKET_BG2),Color(CHECKOUT_TICKET_BG1)],
            
            startPoint: .top, endPoint: .bottom)
    }
}






//ticket bottom section
struct TicketBottomSection: View {
    @Binding var showPopup:Bool
    var grandTotal : Int
    var convinentFee : Int
    var body: some View {
        Group{
            //convenient fee
            ConvenientFeeView(convinentFee: convinentFee)
            
            // cancelation policy btn
            CancelationPolicyBtn(showPopup: $showPopup)
            
            
            //divider
            TicketDivider()
            
            //total
            HStack{
                Text(LABEL_TOTAL)
                    .foregroundColor(Color(BTN_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_3))
                    .fontWeight(.bold)
                Spacer()
                Text("\(grandTotal)Ks")
                    .foregroundColor(Color(BTN_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_3))
                    .fontWeight(.bold)
                
            }.padding(.top,MARGIN_MEDIUM_3)
            
            
            
            
        }
    }
}





//convenient fee view
struct ConvenientFeeView: View {
    var convinentFee : Int
    var body: some View {
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
            Text("\(convinentFee)Ks")
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_2))
                .fontWeight(.medium)
        }
    }
}


//cancelation policy btn
struct CancelationPolicyBtn: View {
    
    @Binding var showPopup:Bool
    var body: some View {
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
            .onTapGesture {
                withAnimation {
                    showPopup.toggle()
                }
            }
            Spacer()
        }.padding(.bottom,20)
    }
}
