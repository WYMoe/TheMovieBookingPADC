//
//  SnackScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 15/05/2023.
//

import SwiftUI

struct SnackScreen: View {
    var token : String
    @State var isSnackCartShowing:Bool = false
    @Environment(\.dismiss) var dismiss
    @State var snackCategory : [SnackCategoryVO] = []
    @State var snacks : [SnackVO]? = nil
    @State var categoryId : Int = 0
    @State var snackId : Int = 0
    @State var isPresented : Bool = false
    
    var movieTitle : String
    var movieId:Int
    var cinema : String
    var screenStatus : Int
    var selectedDate : String
    var selectedTime : String
    var ticketCountForCheckout : Int
    var seatNamesForCheckout : String
    var ticketsPriceForCheckout : Int
    var timeslotId : Int
    var cityId : Int
    var cityName : String
    let mBookingModel : MovieBookingModel = MovieBookingModelImpl.shared

    var body: some View {
        
      
        
            
            //zstack
            ZStack{
                
                
                Color(PRIMARY_COLOR)
                
                //vstack
                VStack(alignment: .center,spacing: 0.0){
                    
                    //appbar
                    SnackScreenAppbarView(){
                        dismiss()
                    }
                    
                    //tab bar
                    SnackTabView(snackCategory: $snackCategory,snackItems: $snacks,mBookingModel: mBookingModel,token: token).padding([.leading,.trailing])
                        .padding(.bottom,MARGIN_XLARGE)
                        
                    //snack grid
                    SnackGridSection(snacks: $snacks, snackId: $snackId)
                    
                    
                    //cart view
                    if(isSnackCartShowing){
                        
                        SnackCartView(snacks: $snacks)
                    }
                    
                   
                   //total snack button
                    TotalSnackPriceBtnView(isSnackCartShowing: $isSnackCartShowing,snacks: $snacks, isPresented: $isPresented)
                    

                    //spacer
                     Spacer()
                    
                    
                }.padding(.top,MARGIN_MEDIUM_2)
            }.background(Color(PRIMARY_COLOR))
            .onAppear{
                requestData()
            }
            .navigationDestination(isPresented: $isPresented, destination: {
                CheckOutScreen(movieTitle: movieTitle, movieId: movieId, cinema: cinema, screenStatus: screenStatus,selectedDate: selectedDate,selectedTime: selectedTime,ticketCountForCheckout: ticketCountForCheckout,seatNamesForCheckout: seatNamesForCheckout,ticketsPriceForCheckout: ticketsPriceForCheckout,snacksForCheckout: $snacks,timeslotId:timeslotId,cityId:cityId,cityName:cityName )
            })
            .navigationBarBackButtonHidden(true)
       
    }
    
    func requestData(){
        
        //get snack category
        mBookingModel.getSnackCategory(token: token) { snackCategory in
            
            self.snackCategory = snackCategory
            self.snackCategory.insert(SnackCategoryVO(id: 9999,title:"All",titleMM:"All",isActive: 1,createdAt: "",isSelected: true), at: 0)
          
        } onFailure: { error in
            
        }
        
        //get snacks
        mBookingModel.getSnacks(token: token) { snacks in
            self.snacks = snacks
        } onFailure: { error in
            
        }

        
        

    }
}

struct SnackScreen_Previews: PreviewProvider {
    static var previews: some View {
        SnackScreen(token: "",movieTitle: "",movieId: 0, cinema: "",screenStatus: 0,selectedDate: "",selectedTime: "",ticketCountForCheckout: 0,seatNamesForCheckout: "",ticketsPriceForCheckout: 0,timeslotId: 0,cityId: 0, cityName: "")
    }
}


//appbar
struct SnackScreenAppbarView: View {
    var onTapBack:()->Void = {
        
    }
    var body: some View {
        HStack(spacing:50){
            
            //IC_BACK
            Image(systemName: IC_BACK)
                .resizable()
                .frame(width: MARGIN_CARD_MEDIUM_2,height: MARGIN_MEDIUM_3)
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .padding(.leading,MARGIN_MEDIUM_3)
                .onTapGesture {
                    onTapBack()
                }
            //title
            Text(LABEL_GRAB_A_BITE)
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: MARGIN_MEDIUM_3))
                .fontWeight(.bold)
            
            
            //search and skip
            HStack{
                
                //search
                Image(systemName: IC_SEARCH)
                    .resizable()
                    .frame(width: MARGIN_MEDIUM_3,height: MARGIN_MEDIUM_3)
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                Spacer()
                
                //skip
                Text(LABEL_SKIP)
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_3))
                    .fontWeight(.bold)
            }
            .padding(.leading,MARGIN_XLARGE)
            .padding(.trailing,MARGIN_MEDIUM_3)
            
            
            
            
        }
        .padding(.bottom,MARGIN_XLARGE_2)
    }
}

//snack grid
struct SnackGridSection: View {
    @Binding var snacks : [SnackVO]?
    @Binding var snackId : Int
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            LazyVGrid(columns: [GridItem(spacing: -MARGIN_MEDIUM_3),GridItem()],spacing: 25) {
                ForEach(snacks ?? [],id:\.id){
                    snack in
                    //snack item
                   
                    SnackGridItemView(snack: snack,snackId: $snackId, ontapAddQuantity: {
                        id in
                        
                        let index = snacks?.firstIndex(where: { s in
                            id == s.id
                        })
                    
                        snacks?[index ?? 0].quantity!+=1
                        
                        
                    }, ontapIncerase: {
                        id in
                        
                        let index = snacks?.firstIndex(where: { s in
                            id == s.id
                        })
                     
                        snacks?[index ?? 0].quantity!+=1
                        
                    }, ontapDecrease: {
                        id in
                        
                        let index = snacks?.firstIndex(where: { s in
                            id == s.id
                        })
                     
                        snacks?[index ?? 0].quantity!-=1
                        
                    })
                }
            }
        }
    }
}


//snack item view
struct SnackGridItemView: View {
    var snack : SnackVO
    @Binding var snackId : Int
    var ontapAddQuantity : (Int)->Void
    var ontapIncerase : (Int)->Void
    var ontapDecrease : (Int)->Void
    var body: some View {
        //zstack
        ZStack{
            
            //gradient
            LinearGradient(colors: [.gray,.black], startPoint: .topLeading, endPoint: .bottomTrailing)
            
            //vstack
            VStack(alignment: .leading, spacing: 10.0){
                
                //snack img
                VStack(alignment:.center) {

                    AsyncImage(url: URL(string: snack.image ?? "")!) { phase in
                        switch phase {
                        case .empty:
                             ProgressView()
                        case .success(let image):
                             image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: SNACK_IMG_SIZE,height: SNACK_IMG_SIZE)
                               
                        case .failure:
                            Image(systemName: "exclamationmark.icloud")
                            
                        @unknown default:
                            EmptyView()
                        }
                        
                    }
                }.frame(width: 150) //vstack width is used to align center snack img
                
                    //snack name
                Text(snack.name ?? ""
                )
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                    .font(.system(size: TEXT_SMALL))
                
                //price
                Text("\(String(describing:((snack.price ?? 0) * 1000)))KS")
                    .foregroundColor(Color(BTN_COLOR))
                    .font(.system(size: TEXT_SMALL))
                
               
                if(snack.quantity ?? 0 > 0) {
                    //btn row
                    HStack(spacing:0){
                        
                        //increase btn
                        Image(systemName: IC_PLUS_CIRCLE)
                            .frame(width: MARGIN_LARGE,height: MARGIN_LARGE)
                            .foregroundColor(Color(BTN_COLOR))
                            .onTapGesture {
                                print("quantity +")
                                ontapIncerase(snack.id ?? 0)
                            }
                        
                        //item count
                        Text(String(snack.quantity ?? 0))
                            .foregroundColor(Color(BTN_COLOR))
                            .font(.system(size: MARGIN_MEDIUM_2))
                            .padding(MARGIN_MEDIUM)
                        
                        //decrease btn
                        Image(systemName: IC_MINUS_CIRCLE)
                            .frame(width: MARGIN_LARGE,height: MARGIN_LARGE)
                            .foregroundColor(Color(BTN_COLOR))
                            .onTapGesture {
                                print("quantity -")
                                ontapDecrease(snack.id ?? 0)
                            }
                        
                    }
                } else {
                    //add btn
                    Text(LABEL_ADD_BTN)
                        .frame(width: ADD_BTN_WIDTH,height: ADD_BTN_HEIGHT)
                        .background(Color(BTN_COLOR))
                        .cornerRadius(CORNER_RADIUS_SMALL)
                        .onTapGesture {
                            snackId = snack.id ?? 0
                            ontapAddQuantity(snackId)
                        }
                }
                
               
                
            }
        }
        .frame(width: SNACK_GRID_ITEM_WIDTH,height: SNACK_GRID_ITEM_HEIGHT)
        .cornerRadius(CORNER_RADIUS_MEDIUM)
    }
}


//snart cart
struct SnackCartView: View {
    @Binding var snacks : [SnackVO]?
    var body: some View {
        VStack{
            ForEach(snacks ?? [],id:\.id){
                snack in
                
                //cart item
                SnackCartItemView(snack: snack, ontapIncerase: {
                    id in
                    
                    let index = snacks?.firstIndex(where: { s in
                        id == s.id
                    })
                 
                    snacks?[index ?? 0].quantity!+=1
                    
                }, ontapDecrease: {
                    id in
                    
                    let index = snacks?.firstIndex(where: { s in
                        id == s.id
                    })
                 
                    snacks?[index ?? 0].quantity!-=1
                    
                })
            }
            
        }.frame(width: UIScreen.main.bounds.width*0.9, height:CGFloat( (snacks?.filter({ s in
            s.quantity ?? 0 > 0
        }).count ?? 0) * 55))// ( hight : itemcount * 50)
            .background(Color(PRIMARY_COLOR))
            .padding(.bottom,CORNER_RADIUS_MEDIUM)
            .cornerRadius(CORNER_RADIUS_MEDIUM)
    }
}


//snack cart item
struct SnackCartItemView: View {
    var snack : SnackVO
    var ontapIncerase : (Int)->Void
    var ontapDecrease : (Int)->Void
    var price : Int {
        (snack.quantity ?? 0) * (snack.price ?? 0)
        
    }
    var body: some View {
        if (snack.quantity ?? 0 > 0) {
            HStack {
                //item name
                Text(snack.name ?? "")
                    .frame(width: UIScreen.main.bounds.width * 0.2)
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .fontWeight(.medium)
                
                
                Spacer()
                
                
                
                //btn row
                HStack(spacing:0){
                    
                    //increase btn
                    Image(systemName: IC_PLUS_CIRCLE)
                        .frame(width: MARGIN_LARGE,height: MARGIN_LARGE)
                        .foregroundColor(Color(BTN_COLOR))
                        .onTapGesture {
                            print("quantity +")
                            ontapIncerase(snack.id ?? 0)
                        }
                    //item count
                    Text(String(snack.quantity ?? 0))
                        .foregroundColor(Color(BTN_COLOR))
                        .font(.system(size: MARGIN_MEDIUM_2))
                        .padding(MARGIN_MEDIUM)
                    
                    //decrease btn
                    Image(systemName: IC_MINUS_CIRCLE)
                        .frame(width: MARGIN_LARGE,height: MARGIN_LARGE)
                        .foregroundColor(Color(BTN_COLOR))
                        .onTapGesture {
                            print("quantity -")
                            ontapDecrease(snack.id ?? 0)
                        }
                    
                }
                
                
                //spacer
                Spacer()
                
                //price
                Text("\(price)000Ks")
                    .frame(width: UIScreen.main.bounds.width * 0.2)
                    .foregroundColor(Color(BTN_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .fontWeight(.bold)
            }
        }
    }
}


//total snack price btn view
struct TotalSnackPriceBtnView: View {
    @Binding var isSnackCartShowing:Bool
    @Binding var snacks : [SnackVO]?
    @Binding var isPresented : Bool
    var count : Int  {
        var c : Int = 0
        snacks?.filter({ s in
            s.quantity ?? 0 > 0
        }).forEach({ s in
             c+=s.quantity ?? 0
        })
        return c
    }
    var totalPrice : Int {
        var t : Int = 0
        snacks?.filter({ s in
            s.quantity ?? 0 > 0
        }).forEach({ s in
            t += ((s.quantity ?? 0) * (s.price ?? 0) * 1000)
        })
        return t
    }
    
    var body: some View {
        HStack{
            
            //snack ic
            Image(IC_SNACK)
                .overlay(BadgeView(count: count)
                    .offset(x:MARGIN_MEDIUM,y:-MARGIN_CARD_MEDIUM_2)
                )
            
            //btn
            Image(systemName:  isSnackCartShowing ? IC_DROPUP : IC_DROPDOWN )
                .onTapGesture {
                    withAnimation{
                        isSnackCartShowing.toggle()
                    }
                  
                }
            
            //spacer
            Spacer()
            
            //total snack price
            Text("\(totalPrice)Ks")
                .foregroundColor(Color(PRIMARY_COLOR))
                .font(.system(size: MARGIN_MEDIUM_2))
                .fontWeight(.bold)
            
            //btn next
         
                Image(systemName: IC_NEXT)
                    .foregroundColor(Color(PRIMARY_COLOR))
                    .onTapGesture {
                        isPresented = true
                    }
            
        
            
            
        }
        
        .padding([.leading,.trailing])
        .frame(width: UIScreen.main.bounds.width*0.9,height: MARGIN_XXLARGE)
        .background(Color(BTN_COLOR))
        .cornerRadius(CORNER_RADIUS_MEDIUM)
        
    }
}
