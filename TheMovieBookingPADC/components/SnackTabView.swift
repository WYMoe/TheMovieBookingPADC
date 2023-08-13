//
//  SnackTabView.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 15/05/2023.
//

import SwiftUI

struct SnackTabView: View {
    

    @Binding var snackCategory: [SnackCategoryVO]
    @Binding var snackItems : [SnackVO]?
    let mBookingModel : MovieBookingModel
    let token : String
    
    var body: some View {
       
        
        ScrollView(.horizontal,showsIndicators: false){
            
            ScrollViewReader { scrollView in
                //Hstack
                HStack( spacing:MARGIN_MEDIUM){
                    
                    //for each
                    ForEach(snackCategory,id:\.id){
                        snackType in
                        
                        //SnackTabItem
                        VStack(alignment:.center){
                            
                            //snack type
                            Text(snackType.title ?? "")
                                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                                .fontWeight(.medium)
                                .font(.system(size: TEXT_REGULAR_2X))
                                
                            //underline
                                Rectangle()
                                .fill(snackType.isSelected ? Color(BTN_COLOR) : .clear)
                                    .frame(height:MARGIN_SMALL)
                        }
                        .frame(width:MARGIN_XXXLARGE)
                        .onTapGesture {
                            
                            
                            snackCategory = snackCategory.map{
                                iteratedSnack in
                        
                                if (snackType.title == iteratedSnack.title){
                                    
                                    return SnackCategoryVO(id:iteratedSnack.id,title:iteratedSnack.title,titleMM:iteratedSnack.titleMM,isActive: iteratedSnack.isActive,createdAt: iteratedSnack.createdAt,isSelected: true)
                                } else {
                                    return SnackCategoryVO(id:iteratedSnack.id,title:iteratedSnack.title,titleMM:iteratedSnack.titleMM,isActive: iteratedSnack.isActive,createdAt: iteratedSnack.createdAt,isSelected: false)
                                }
                        
                            }
                            
                            
                            
                            if snackType.title == "All" {
                                mBookingModel.getSnacks( token: token) { snacks in
                                    snackItems = snacks
                                } onFailure: { error in
                                    
                                }
                            }else {
                                mBookingModel.getSnacksByCategory(categoryId: snackType.id ?? 0, token: token) { snacks in
                                    snackItems = snacks
                                } onFailure: { error in
                                    
                                }
                            }
                            

                          
                        
                            scrollView.scrollTo(snackType.id,anchor: .center)
                            
                        
                        
                        }
                    }
                }
            }
        }
        
    }
}


//struct SnackTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        SnackTabView()
//    }
//}
