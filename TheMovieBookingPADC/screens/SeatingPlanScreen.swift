//
//  SeatingPlanScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 19/05/2023.
//

import SwiftUI

struct SeatingPlanScreen: View {
    @Environment(\.presentationMode) var presentation
    
    var token : String
    var timeslotId : Int
    var clickedDate : String
    var cityId : Int
    var cityName : String
    @State var movieSeatsPlan : [MovieSeatVO]? = nil
    var seatCount : Int {
        var count : Int = 0
        movieSeatsPlan?.filter({ s in
            s.isSelected == true
        }).forEach({ s in
             count+=1
        })
        return count
    }
    var seatPrice : Int {
        var totalPrice : Int = 0
        movieSeatsPlan?.filter({ s in
            s.isSelected == true
        }).forEach({ s in
            totalPrice += ((s.price ?? 0) * 1000)
        })
        return totalPrice
    }
    
    var selectedSeats : String {
        var seats : String = ""
       seats = movieSeatsPlan?.filter({ s in
            s.isSelected == true
        }).map({ seat in
            seat.seatName ?? ""
        }).joined(separator: ",") ?? ""
        
        return seats
    }
    
    @State var isPresented : Bool = false
    
    var movieTitle : String
    var cinema : String
    var screenStatus : Int
    var selectedDate : String
    var selectedTime : String
    @State var seatNamesForCheckout : [String] = []
    var movieId : Int
    
    

    let mBookingModel : MovieBookingModel = MovieBookingModelImpl.shared

    var body: some View {
     
            ZStack{
                
                //background
                Color.black
                
                //body
                VStack(spacing:0.0){
                    //Appbar
                    SeatingPlanAppbarView{
                        presentation.wrappedValue.dismiss()
                    }
                    
                    //screen view
                    ScreenView().padding(.top,MARGIN_MEDIUM_2)
                    
                    //price label
                    Text("Normal (4500Ks)")
                        .foregroundColor(Color(LABEL_COLOR))
                        .font(.system(size: MARGIN_MEDIUM_2))
                        .padding(.bottom,MARGIN_MEDIUM)
                    
                    
                    
                    //movie seats
                    MovieSeatsZoomableContainerView(
                        view: AnyView(MovieSeatGridView(movieSeats: $movieSeatsPlan, onTapSeat: {
                            seat in
                            
                            // get index of selected seat
                            let index = movieSeatsPlan?.firstIndex(where: { s in
                                seat.seatName == s.seatName
                            })
                            
                            //update selected seat
                            movieSeatsPlan?[index ?? 0] = seat
                           
                            
                            
                        })),
                       
                        viewHeight: MOVIE_SEAT_VIEW_HEIGHT,
                        seatCount: seatCount,
                        seatPrice: seatPrice, isPresented: $isPresented
                    ).padding([.leading,.trailing], MARGIN_SMALL)
                  
                    Spacer()
                    
                    
                }.padding(.top,MARGIN_XXLARGE)
                
            }.edgesIgnoringSafeArea(.all)
                .onAppear{
                    
                   
                   
                   
                    mBookingModel.getSeatingPlanByShowtime(token: token, timeslotId: timeslotId, date: clickedDate) {
                        movieSeats in
                        self.movieSeatsPlan = movieSeats
                        
                    } onFailure: { error in
                        print(error)
                    }
                    
                  
                    
                    print(seatNamesForCheckout)


                   
                }
                .navigationDestination(isPresented: $isPresented, destination: {
                    SnackScreen(token: token, isSnackCartShowing: false,movieTitle: movieTitle,movieId: movieId, cinema: cinema,screenStatus: screenStatus,selectedDate: selectedDate,selectedTime: selectedTime,ticketCountForCheckout: seatCount,seatNamesForCheckout: selectedSeats,ticketsPriceForCheckout: seatPrice,timeslotId: timeslotId,cityId:cityId,cityName:cityName)
                    
                })
                .navigationBarBackButtonHidden(true)
  
            
    }
    
 
}

struct SeatingPlanScreen_Previews: PreviewProvider {
    static var previews: some View {
        SeatingPlanScreen(token: "", timeslotId: 0, clickedDate: "",cityId: 0, cityName:"", movieTitle: "",cinema: "",screenStatus: 0,selectedDate: "",selectedTime: "",movieId: 0)
    }
}


//appbar
struct SeatingPlanAppbarView: View {
    
    
    var onTapBack:()->Void = {
        
    }
    var body: some View {
        HStack{
            Image(systemName: IC_BACK)
                .resizable()
                .frame(width: MARGIN_CARD_MEDIUM_2,height: MARGIN_MEDIUM_3)
                .foregroundColor(.white)
            Spacer()
            
        }.padding([.leading,.trailing],MARGIN_MEDIUM_3)
            .onTapGesture {
                onTapBack()
            }
    }
}


//screen view
struct ScreenView: View {
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            Image(IC_SCREEN)
                .resizable()
                .frame(width: IC_SCREEN_WIDTH,height: IC_SCREEN_HEIGHT)
                .clipped()
            
            Text(LABEL_SCREEN)
                .foregroundColor(.white)
                .font(.system(size: MARGIN_MEDIUM_2))
                .padding(.bottom,MARGIN_LARGE)
        }
    }
}

//movie seat grid view
struct MovieSeatGridView: View {
    var columns = getGridItems(numberOfColumns: 14, spacing: 20)
    @Binding var movieSeats : [MovieSeatVO]?
    var onTapSeat: (( _ seat : MovieSeatVO)->Void)?

    var body: some View {
        LazyVGrid(columns: columns,spacing: 10) {
            ForEach(movieSeats ?? [MovieSeatVO](),id:\.idForGrid){
                seat in
                MovieSeatItemView(seat: seat)
                    .onTapGesture {
                        guard let onTapSeat = self.onTapSeat else {
                            return
                        }
                        
                        if seat.isAvailable() {
                            onTapSeat( MovieSeatVO(idForGrid: seat.idForGrid,id: seat.id,text: seat.text,type: seat.type,seatName: seat.seatName,symbol: seat.symbol,price: seat.price,isSelected: true) )
                        }
                        
                        if seat.isSelected {
                            onTapSeat( MovieSeatVO(idForGrid: seat.idForGrid,id: seat.id,text: seat.text,type: seat.type,seatName: seat.seatName,symbol: seat.symbol,price: seat.price,isSelected: false) )
                        }
                    }
            }
           
        }
    }
}

//movie seat item
struct MovieSeatItemView: View {
    var seat:MovieSeatVO? = nil
    var body: some View {
        if seat?.isSelected  ?? false {
            
            Image(IC_SEAT_AVAILABLE)
                
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color(BTN_COLOR))
                .frame(width: MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
                .clipped()
        } else  if seat?.isAvailable() ?? false {
                Image(IC_SEAT_AVAILABLE)
                    .resizable()
                    .frame(width: MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
                    .clipped()
                
            }else if seat?.isTaken() ?? false {
                Image(IC_SEAT_TAKEN)
                    .resizable()
                    .frame(width: MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
                    .clipped()
            }else if seat?.isText() ?? false {
                
                Text(seat?.symbol ?? "")
                    .font(.system(size:MARGIN_CARD_MEDIUM_2))
                    .frame(width:MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
                    .foregroundColor(Color(LABEL_COLOR))
            } else {
                Color.clear
                    .frame(width: MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
            }
        }
    
}
