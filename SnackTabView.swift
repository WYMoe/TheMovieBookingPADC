//
//  SnackTabView.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 15/05/2023.
//

import SwiftUI

struct SnackTabView: View {
    
    @State var snacks = dummySnacks
    
    var body: some View {
       
        
        ScrollView(.horizontal,showsIndicators: false){
            
            ScrollViewReader { scrollView in
                //Hstack
                HStack( spacing:MARGIN_MEDIUM){
                    
                    //for each
                    ForEach(snacks,id:\.snackType){
                        snack in
                        //SnackTypeItem
                        VStack(alignment:.center){
                            Text(snack.snackType)
                                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                                .fontWeight(.medium)
                                .font(.system(size: TEXT_REGULAR_2X))
                                
                                Rectangle()
                                    .fill(snack.isSelected ? Color(BTN_COLOR) : .clear)
                                    .frame(height:MARGIN_SMALL)
                        }
                        .frame(width:MARGIN_XXXLARGE)
                        .onTapGesture {
                        snacks = snacks.map{
                                iteratedSnack in
                        
                                if (snack.snackType == iteratedSnack.snackType){
                                    return SnackVO(snackType: iteratedSnack.snackType,isSelected: true)
                                } else {
                                    return SnackVO(snackType: iteratedSnack.snackType,isSelected: false)
                                }
                        
                            }
                        
                            scrollView.scrollTo(snack.snackType,anchor: .center)
                        
                        
                        }
                    }
                }
            }
        }
        
    }
}


struct SnackTabView_Previews: PreviewProvider {
    static var previews: some View {
        SnackTabView()
    }
}
