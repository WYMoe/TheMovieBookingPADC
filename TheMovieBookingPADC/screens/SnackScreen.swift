//
//  SnackScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 15/05/2023.
//

import SwiftUI

struct SnackScreen: View {
    
    @State var isSnackCartShowing:Bool = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        //navigationstack
        NavigationStack {
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
                    SnackTabView().padding([.leading,.trailing])
                        .padding(.bottom,MARGIN_XLARGE)
                        
                    //snack grid
                    SnackGridSection()
                    
                    
                    //cart section
                    if(isSnackCartShowing){
                        
                        SnackCartSection()
                           
                    }
                    
                   
                   //bottom button
                   
                        TotalSnackBtnSection(isSnackCartShowing: $isSnackCartShowing)
                    

                    
                        
                        
                    
                    //spacer
                     Spacer()
                    
                    
                }.padding(.top,MARGIN_MEDIUM_2)
            }.background(Color(PRIMARY_COLOR))
        }.navigationBarBackButtonHidden(true)
       
    }
}

struct SnackScreen_Previews: PreviewProvider {
    static var previews: some View {
        SnackScreen()
    }
}

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

struct SnackGridSection: View {
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            LazyVGrid(columns: [GridItem(spacing: -MARGIN_MEDIUM_3),GridItem()],spacing: 25) {
                ForEach(1...6,id:\.self){
                    _ in
                    SnackGridItemView()
                }
            }
        }
    }
}

struct SnackGridItemView: View {
    var body: some View {
        //zstack
        ZStack{
            
            //gradient
            LinearGradient(colors: [.gray,.black], startPoint: .topLeading, endPoint: .bottomTrailing)
            
            //vstack
            VStack(alignment: .leading, spacing: 10.0){
                
                //snack img
                VStack(alignment:.center) {
                    Image("snack")
                        .resizable()
                        .frame(width: SNACK_IMG_SIZE,height: SNACK_IMG_SIZE)
                }.frame(width: 150) //vstack width is used to align center snack img
                
                    //snack name
                Text("Potato Chips")
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                    .font(.system(size: TEXT_SMALL))
                
                //price
                Text("1000 KS")
                    .foregroundColor(Color(BTN_COLOR))
                    .font(.system(size: TEXT_SMALL))
                
                //add btn
                Text(LABEL_ADD_BTN)
                    .frame(width: ADD_BTN_WIDTH,height: ADD_BTN_HEIGHT)
                    .background(Color(BTN_COLOR))
                    .cornerRadius(CORNER_RADIUS_SMALL)
                
            }
        }
        .frame(width: SNACK_GRID_ITEM_WIDTH,height: SNACK_GRID_ITEM_HEIGHT)
        .cornerRadius(CORNER_RADIUS_MEDIUM)
    }
}

struct SnackCartSection: View {
    var body: some View {
        VStack{
            ForEach(1...2,id:\.self){
                _ in
                
                //cart item
                SnackCartItemView()
            }
            
        }.frame(width: UIScreen.main.bounds.width*0.9, height: 100)// ( itemcount * 50)
            .background(Color(PRIMARY_COLOR))
            .padding(.bottom,CORNER_RADIUS_MEDIUM)
            .cornerRadius(CORNER_RADIUS_MEDIUM)
    }
}

struct SnackCartItemView: View {
    var body: some View {
        HStack {
            //item name
            Text("Large Cola")
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
                //item count
                Text("1")
                    .foregroundColor(Color(BTN_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .padding(MARGIN_MEDIUM)
                
                //decrease btn
                Image(systemName: IC_MINUS_CIRCLE)
                    .frame(width: MARGIN_LARGE,height: MARGIN_LARGE)
                    .foregroundColor(Color(BTN_COLOR))
                
            }
            
            //spacer
            Spacer()
            
            //price
            Text("1000Ks")
                .foregroundColor(Color(BTN_COLOR))
                .font(.system(size: MARGIN_MEDIUM_2))
                .fontWeight(.bold)
        }
    }
}

struct TotalSnackBtnSection: View {
    @Binding var isSnackCartShowing:Bool
    var body: some View {
        HStack{
            
            //snack ic
            Image(IC_SNACK)
                .overlay(BadgeView(count: 5)
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
            Text("2000Ks")
                .foregroundColor(Color(PRIMARY_COLOR))
                .font(.system(size: MARGIN_MEDIUM_2))
                .fontWeight(.bold)
            
            //btn next
            NavigationLink {
                CheckOutScreen(isSnacksShowing: true,isCancelPolicyShowing: true)
            }label: {
                Image(systemName: IC_NEXT)
                    .foregroundColor(Color(PRIMARY_COLOR))
            }
        
            
            
        }
        .padding([.leading,.trailing])
        .frame(width: UIScreen.main.bounds.width*0.9,height: MARGIN_XXLARGE)
        .background(Color(BTN_COLOR))
        .cornerRadius(CORNER_RADIUS_MEDIUM)
    }
}
