//
//  TicketConfirmationScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 20/05/2023.
//

import SwiftUI

struct TicketConfirmationScreen: View {
    @State var showPopup: Bool = true
    var CheckoutData : CheckoutVO
    
    var cinemaName : String
    var status : Int
    var cityId : Int
    var cityName: String
    @State var bookedMovie : MovieDetailVO? = nil
    let mBookingModel : MovieBookingModel = MovieBookingModelImpl.shared
    @State var isPresented : Bool = false
    var body: some View {
     
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
                    TicketConfirmationTicketView(checkoutData: CheckoutData, bookedMovie: bookedMovie ?? MovieDetailVO() ,cinemaName: cinemaName,status: status)
                        .padding(.bottom,MARGIN_XXLARGE)
                    
                    
                    //qr and code view
                    QRCodeView(qrImg:CheckoutData.qrcode ?? "")
                        .padding(.bottom,MARGIN_XXLARGE)
                    
                    //btn
                   
                        Text("Done")
                            .foregroundColor(.black)
                                .frame(width: 176,height: 40)
                                .background(Color(BTN_COLOR))
                            .cornerRadius(CORNER_RADIUS_SMALL)
                            .onTapGesture {
                                isPresented = true
                               
                            }
              
                            
                    
                    Spacer()
                }
            }.edgesIgnoringSafeArea(.all)
                .background(.black)
                .onAppear{
                    
                    mBookingModel.getMovieDetail(movieId: CheckoutData.movieId ?? 0, onSuccess: { movie in
                        self.bookedMovie = movie
                    }) { error in
                        
                    }
                    
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
                .navigationDestination(isPresented: $isPresented, destination: {
                    MainScreen(selection: 0, cityId: cityId, cityName: cityName)
                })
        .navigationBarBackButtonHidden(true)
    }
}

struct TicketConfirmationScreen_Previews: PreviewProvider {
    static var previews: some View {
        TicketConfirmationScreen(showPopup: true,CheckoutData: CheckoutVO(),cinemaName: "",status: 0, cityId: 0,cityName: "")
    }
}

struct TicketConfirmationMovieInfoView: View {
    var checkoutData : CheckoutVO
    var bookedMovie : MovieDetailVO
    var cinemaName : String
    var status : Int
    var body: some View {
        HStack(alignment:.top,spacing:MARGIN_MEDIUM_3){
    //movie image
            AsyncImage(url: URL(string: "\(BASE_IMAGE_URL)\(bookedMovie.posterPath ?? "")")!) { phase in
            switch phase {
            case .empty:
                 ProgressView()
            case .success(let image):
                 image
                    .resizable()
                    .frame(width: 120,height: 150)
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    
            case .failure:
                Image(systemName: "exclamationmark.icloud")

            @unknown default:
                EmptyView()
            }

        }
            VStack(alignment:.leading){
                
                //movie title
                HStack{
                    Text(bookedMovie.originalTitle ?? "")
                        .foregroundColor(.white)
                        .font(.system(size:MARGIN_MEDIUM_2))
                        .fontWeight(.bold)
                    Text("(3D)(UA)")
                        .foregroundColor(.white)
                        .font(.system(size:MARGIN_MEDIUM_2))
                }.padding(.bottom,MARGIN_CARD_MEDIUM)
                
                //cinema name
                Text(cinemaName)
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
                    Text("\(String(checkoutData.totalSeat ?? 0))")
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
                    Text(checkoutData.seat ?? "")
                        .foregroundColor(.white)
                        .font(.system(size:MARGIN_MEDIUM_2))
                        .fontWeight(.bold)
                    Text(" (Screen \(status))")
                        .foregroundColor(Color(LABEL_COLOR))
                        .font(.system(size:MARGIN_MEDIUM_2))
                }
                
                
            }
            
        }
    }
}

struct TicketConfirmationDateTImeLocation: View {
    var checkoutData : CheckoutVO
    var formattedDate : String {
        
        let inputFormat = DateFormatter()
        inputFormat.dateFormat = "yyyy-M-d"
        
        if let date = inputFormat.date(from: checkoutData.bookingDate ?? "") {
            let outputFormat = DateFormatter()
            outputFormat.dateFormat = "E, d MMM, yyyy"
            return outputFormat.string(from: date)
        }
        
        return ""
    }
    var body: some View {
        HStack(alignment:.firstTextBaseline){
            
            //date
            VStack{
                Image(IC_CALENDER)
                    .resizable()
                    .frame(width: MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
                Text(formattedDate)
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
                Text(checkoutData.timeslot?.startTime ?? "")
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
    var checkoutData : CheckoutVO
    var bookedMovie : MovieDetailVO
    var cinemaName : String
    var status : Int
    var body: some View {
        VStack{
            //movie info
            TicketConfirmationMovieInfoView(checkoutData: checkoutData, bookedMovie: bookedMovie,cinemaName: cinemaName,status: status)
            
            //cemicircle and dotted line
            CemiCircleAndDottedLineView()
            
            //date time and location
            TicketConfirmationDateTImeLocation(checkoutData:checkoutData)
            
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
    var qrImg : String
    var body: some View {
        VStack {
            
            //qr img

            AsyncImage(url: URL(string: "\(BASE_URL)/\(qrImg)")!) { phase in
            switch phase {
            case .empty:
                 ProgressView()
            case .success(let image):
                 image
                    .resizable()
                    .frame(width: MARGIN_XLLARGE,height: MARGIN_XLLARGE)
                   
                    
            case .failure:
                Image(systemName: "exclamationmark.icloud")

            @unknown default:
                EmptyView()
            }

        }
            
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
