////
////  LoginScreen.swift
////  TheMovieBookingPADC
////
////  Created by Wai Yan Moe on 05/05/2023.
////
//
//import SwiftUI
//
//struct LoginScreen: View {
//
//    var body: some View {
//        ZStack{
//            Color.black
//            VStack(spacing:0.0){
//
//
//                //logo
//                Image(IC_LOGO)
//                    .padding(.bottom,MARGIN_XXXLARGE)
//
//
//                Group{
//                    //label
//                    Text(LABEL_VERIFY)
//                        .foregroundColor(Color(PRIMAYR_LIGHT_COLOR))
//                        .font(.system(size: TEXT_REGULAR_3X))
//                    //todo::add custom font
//
//                    //label
//                    Text(LABEL_WILL_SEND_DIGITS)
//                        .foregroundColor(Color(LABEL_COLOR))
//                        .multilineTextAlignment(.center)
//                        .padding(.bottom,MARGIN_XXXLARGE)
//
//
//                    //countrycode and ph number
//                    CountryCodeAndPhNumberView()
//                        .padding(EdgeInsets(top: 0, leading: MARGIN_XLARGE, bottom: MARGIN_XXLARGE, trailing: MARGIN_XLARGE))
//
//
//                        //btn verify
//                        LoginBtnView(label: LABEL_VERIFY,color: BTN_COLOR)
//                            .padding(.boqttom,MARGIN_LARGE)
//
//
//
//                    //divider
//                    DividerView().padding(.bottom,MARGIN_LARGE)
//
//                    //btn google
//
//                    LoginBtnView(label: LABEL_CONTINUE_WITH_GOOGLE,icon: IC_GOOGLE,color: PRIMAYR_LIGHT_COLOR)
//                        .padding(.bottom,MARGIN_XXXLARGE)
//
//                    //terms and condition
//                    Text(LABEL_TERMS_AND_CONDITIONS)
//                        .foregroundColor(Color(LABEL_COLOR))
//                        .font(.system(size: TEXT_SMALL))
//                }
//
//
//
//
//            }
//        }.edgesIgnoringSafeArea([.top,.bottom])
//    }
//}
//
//struct LoginScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginScreen()
//    }
//}
//
//
//struct DividerView: View {
//    var body: some View {
//        HStack{
//
//            Rectangle()
//                .frame(width: DIVIDER_WIDTH,height: 1)
//                .foregroundColor(Color(LABEL_COLOR))
//                .padding([.leading,.trailing],MARGIN_MEDIUM_3)
//
//            Text("or")
//                .foregroundColor(Color(PRIMAYR_LIGHT_COLOR))
//
//            Rectangle()
//                .frame(width: DIVIDER_WIDTH,height: 1)
//                .foregroundColor(Color(LABEL_COLOR))
//                .padding([.leading,.trailing],MARGIN_MEDIUM_3)
//
//        }
//    }
//}

import SwiftUI

struct MoviesCarousel: View {
    
   let categoryName: String
    
   var body: some View {
       VStack {
           HStack {
               Text(categoryName)
                   .font(.system(size: 14, weight: .heavy))
                   .padding(.vertical, 6)
                   .padding(.horizontal, 12)
                   .background(Color.green)
                   .foregroundColor(.white)
                   .cornerRadius(2)
               Spacer()
           }.padding(.horizontal)
           .padding(.top)
            
           ScrollView(.horizontal, showsIndicators: false) {
               HStack(alignment: .top, spacing: 16) {
                   ForEach(1...5,id:\.self) { _ in
                       GeometryReader { proxy in
                           let scale = getScale(proxy: proxy)
                           
                                   
                                       Image("Offer borard")
                                           .resizable()
                                         //  .scaledToFill()
                                           .frame(width: 270)
                                           .clipped()
                                           .cornerRadius(8)
                                           .overlay(
                                               RoundedRectangle(cornerRadius: 8)
                                                   .stroke(Color(white: 0.4))
                                           )
                                           .shadow(radius: 3)
                           
                                           //.resizable()
                                           //.aspectRatio(contentMode: .fill)
                                          // .frame(width: 180,height: 170)
                                     
                                   
                               
                            
                               .scaleEffect(.init(width: scale, height: scale))
                               //.animation(.spring(), value: 1)
                               //.animation(.easeOut(duration: 1))
                                
                               .padding(.vertical)
                       } //End Geometry
                      .frame(width: 200,height: 200)
                       .padding(.horizontal, 32)
                       .padding(.vertical, 32)
                   } //End ForEach
                   Spacer()
                       .frame(width: 16)
               } //End HStack
           }// End ScrollView
       }//End VStack
   }
    
   func getScale(proxy: GeometryProxy) -> CGFloat {
       let midPoint: CGFloat = 125
        
       let viewFrame = proxy.frame(in: CoordinateSpace.global)
        
       var scale: CGFloat = 1.0
       let deltaXAnimationThreshold: CGFloat = 125
        
       let diffFromCenter = abs(midPoint - viewFrame.origin.x - deltaXAnimationThreshold / 2)
       if diffFromCenter < deltaXAnimationThreshold {
           scale = 1 + (deltaXAnimationThreshold - diffFromCenter) / 500
       }
        
       return scale
   }
}


struct MoviesCarousel_Previews: PreviewProvider {
   static var previews: some View {
       MoviesCarousel(categoryName: "Top Movie")
   }
}
