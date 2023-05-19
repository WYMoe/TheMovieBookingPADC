//
//  MoviesScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 10/05/2023.
//

import SwiftUI


struct MoviesScreen: View {
    @State var isActiveNowShowing:Bool = true
    @State var isActiveComingSoon:Bool = false
    @State var isShowing:Bool = false
    
    
   // var movies = [MovieItemView(isActiveComingSoon: false)]
    var body: some View {
      //  NavigationStack {
            ZStack {
                Color(PRIMARY_COLOR)
                VStack(spacing:0.0) {
              
                    //appbar
                    AppbarView()
                    
                    //promotion slider
                    SliderView()
                    
                    //tab btn
                    TabBtnRowSection(isActiveNowShowing: $isActiveNowShowing, isActiveComingSoon: $isActiveComingSoon)
                    
                    //nowshowing and coming soon
                    NowShowingAndComingSoonSection(isActiveComingSoon: $isActiveComingSoon,isShowing: $isShowing)
                    
                }.padding(.top,MARGIN_MEDIUM_3)
                
                
            }
            .background(.black)
            .edgesIgnoringSafeArea([.bottom])
            .toolbar(.hidden)
            .fullScreenCover(isPresented: $isShowing) {
                MovieDetailsScreen(isActiveComingSoon: $isActiveComingSoon)
            }
        //}
        
    }
}

struct MoviesScreen_Previews: PreviewProvider {
    static var previews: some View {
        MoviesScreen()
    }
}




struct SliderItem: View {
    
    init() {
        UIPageControl.appearance().pageIndicatorTintColor = .gray
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color(BTN_COLOR))
    }
    var body: some View {
        Image(LABEL_PROMOTION)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: SLIDER_VIEW_WIDTH ,height: PROMOTION_IMG_HEIGHT)
    }
}


struct SliderView: View {
    var body: some View {
        TabView{
            
            ForEach(1...5,id:\.self){
                _ in
                SliderItem()
                
            }
            
        }.tabViewStyle(.page)
        
            .frame(width:SLIDER_VIEW_WIDTH,height: SLIDER_VIEW_HEIGHT)
    }
}

struct TabButtonView: View {
    @Binding var isActive:Bool
    var label: String = ""
    var body: some View {
        Text(label)
            .frame(width:MOVIE_SCREEN_TAB_BUTTON_WIDTH,height: MOVIE_SCREEN_TAB_BUTTON_HEIGHT)
            .foregroundColor(Color(PRIMARY_COLOR))
            .background( isActive ? Color(BTN_COLOR) : Color(PRIMARY_DARK_COLOR))
            .cornerRadius(MOVIE_SCREEN_TAB_BUTTON_CORNER_RADIUS)
        
    }
}

struct TabBtnRowSection: View {
    @Binding var isActiveNowShowing:Bool
    @Binding var isActiveComingSoon:Bool
    
    var body: some View {
        ZStack{
            Color(PRIMARY_DARK_COLOR)
            HStack{
                TabButtonView(isActive: $isActiveNowShowing,label:LABEL_NOWSHOWING)
                    .onTapGesture {
                        isActiveNowShowing = true
                        isActiveComingSoon = false
                       
                    }
                TabButtonView(isActive: $isActiveComingSoon,label:LABEL_COMINGSOON)
                    .onTapGesture {
                        isActiveNowShowing = false
                        isActiveComingSoon = true
                    }
                
                
                
                
                
            }
            
            
        }.frame(width: SLIDER_VIEW_WIDTH,height: MOVIE_SCREEN_TAB_BUTTON_ROW_HEIGHT)
            .cornerRadius(MOVIE_SCREEN_TAB_BUTTON_CORNER_RADIUS)
    }
}


struct NowShowingAndComingSoonSection: View {
    @Binding var isActiveComingSoon:Bool
    @Binding var isShowing: Bool
   
    var body: some View {
        ScrollView{
            
            LazyVGrid(columns: [GridItem(spacing: 0),
                                GridItem(spacing: 0)],spacing: 80) {
                ForEach(1...3,id: \.self) { _ in

                        MovieItemView(isActiveComingSoon: $isActiveComingSoon)
                        .onTapGesture {
                            isShowing.toggle()
                           
                        }
                   

                    
                }
                
            }.padding(.top, MARGIN_XLARGE)
                .padding(.bottom,UIScreen.main.bounds.height * 0.2)
        }.padding(.top,MARGIN_XLARGE)
    }
}
