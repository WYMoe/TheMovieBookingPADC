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
    
    let mBookingModel : MovieBookingModel = MovieBookingModelImpl.shared
    
    
    
    @State var paymentTypes : [PaymentTypeVO]? = nil
    @State var token : String? = nil
    
    var cinema_day_timeslot_id: Int
    var seat_number: String
    var booking_date: String
    var movie_id: Int
    var payment_type_id: Int = 0
    @State var isPresented : Bool = false
    var snacksRequest: [SnackVO]
    @State var snacksforRawdata : [SnackRequestVO]
    @State var checkoutData : CheckoutVO? = nil
    var movieTitle : String
    var cinemaName : String
    var status : Int
    var cityId : Int
    var cityName : String
    var body: some View {
        
        ZStack{
            Color.black
            
            VStack(spacing:0.0){
                
                //appbar
                PaymentScreenAppbarView(){
                    presentation.wrappedValue.dismiss()
                }
                .padding(.bottom,MARGIN_XLARGE_1)
                
                //textfield
                TextFieldNameView(nameText: $nameText)
                    .padding(.bottom,MARGIN_XLARGE)
                
                //btn
                ApplyPromocodeBtnView()
                    .padding(.bottom,MARGIN_XLARGE_1)
                
                
                //choose payment label
                VStack(alignment: .leading){
                    Text(LABEL_CHOOSE_PAYMENT)
                        .foregroundColor(Color(BTN_COLOR))
                        .font(.system(size: TEXT_REGULAR_2X))
                        .fontWeight(.bold)
                        .padding(.bottom,MARGIN_MEDIUM_3)
                    
                    //paymentmethods
                    
                    ForEach(paymentTypes ?? [], id:\.id) {
                        paymentType in
                        PaymentTypeItemView(icon: paymentType.icon ?? "",label: paymentType.title ?? "",id: paymentType.id ?? 0,ontapPayment: {
                            id in
                            
                            //convert from [snackVO] to [snackrequestVO] for rawdata
                            snacksforRawdata =  snacksRequest.filter({ s in
                                s.quantity ?? 0 > 0
                            }).map { snackVO in
                                return SnackRequestVO(id: snackVO.id,quantity: snackVO.quantity)
                            }
                            //checkout
                            mBookingModel.checkout(token: token ?? "", timeslotId: cinema_day_timeslot_id, seatName: seat_number, date: booking_date, movieId: movie_id, paymentId: id, snacks: snacksforRawdata) { checkoutData in
                                if(checkoutData.id != nil){
                                    self.checkoutData = checkoutData
                                    isPresented = true
                                }
                               
                                
                            } onFailure: { error in
                                print(error)
                                
                            }
                        })
                    }
                    
                    
                    
                }
                
                
            }.padding([.leading,.trailing],MARGIN_MEDIUM_3)
            
        }
        .edgesIgnoringSafeArea(.all)
        .navigationDestination(isPresented: $isPresented, destination: {
            TicketConfirmationScreen(CheckoutData: checkoutData ?? CheckoutVO(),cinemaName: cinemaName,status: status,cityId : cityId,cityName:cityName)
        })
        .onAppear{
            
            //get token
            self.token = mBookingModel.getUser().token ?? ""
            //get payments
            mBookingModel.getPaymentTypes(token: token ?? "") { paymentTypes in
                self.paymentTypes = paymentTypes
            } onFailure: { error in
                
            }
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
}

//struct PaymentScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        PaymentScreen()
//    }
//}

//appbar
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

//textfield overlay
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

//textfield name
struct TextFieldNameView: View {
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

//promo code btn
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


//payment type item
struct PaymentTypeItemView: View {
    
    var icon:String = ""
    var label:String = ""
    var id : Int = 0
    var ontapPayment : (Int) -> Void = {
        _ in
    }
    
    var body: some View {
        
        HStack{
            
            AsyncImage(url: URL(string: icon)!) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: MARGIN_XLARGE,height: MARGIN_XLARGE)
                    
                case .failure:
                    Image(systemName: "exclamationmark.icloud")
                    
                @unknown default:
                    EmptyView()
                }
                
            }
            Text(label)
                .foregroundColor(.white)
                .font(.system(size: TEXT_REGULAR))
                .fontWeight(.semibold)
            Spacer()
            Image(systemName:IC_NEXT)
                .foregroundColor(.white)
            
            
            
        }
        .onTapGesture {
            ontapPayment(id)
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
