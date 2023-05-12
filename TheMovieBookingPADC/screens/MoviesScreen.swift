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
    
   // var movies = [MovieItemView(isActiveComingSoon: false)]
    var body: some View {
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
                NowShowingAndComingSoonSection(isActiveComingSoon: $isActiveComingSoon)
                
            }.padding(.top,UIScreen.main.bounds.height * 0.06)
        }.edgesIgnoringSafeArea([.top,.bottom])
        
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
        Image("Offer borard")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 370,height: 170)
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
        
            .frame(width:370,height: 250)
    }
}

struct TabButtonView: View {
    @Binding var isActive:Bool
    var label: String = ""
    var body: some View {
        Text(label)
            .frame(width:170,height: 40)
            .foregroundColor(Color(PRIMARY_COLOR))
            .background( isActive ? Color(BTN_COLOR) : Color(PRIMARY_DARK_COLOR))
            .cornerRadius(5)
        
    }
}

struct TabBtnRowSection: View {
    @Binding var isActiveNowShowing:Bool
    @Binding var isActiveComingSoon:Bool
    var body: some View {
        ZStack{
            Color(PRIMARY_DARK_COLOR)
            HStack{
                TabButtonView(isActive: $isActiveNowShowing,label:"Now Showing")
                    .onTapGesture {
                        isActiveNowShowing = true
                        isActiveComingSoon = false
                    }
                TabButtonView(isActive: $isActiveComingSoon,label:"Coming Soon")
                    .onTapGesture {
                        isActiveNowShowing = false
                        isActiveComingSoon = true
                    }
                
                
                
                
                
            }
            
            
        }.frame(width: 370,height: 55)
            .cornerRadius(5)
    }
}


struct NowShowingAndComingSoonSection: View {
    @Binding var isActiveComingSoon:Bool
    var body: some View {
        ScrollView{
            
            LazyVGrid(columns: [GridItem(spacing: 0),
                                GridItem(spacing: 0)],spacing: 80) {
                ForEach(1...3,id: \.self) { _ in
                    
                    MovieItemView(isActiveComingSoon: $isActiveComingSoon)
                }
                
            }.padding(.top, 28)
        }.padding(.top,30)
    }
}
