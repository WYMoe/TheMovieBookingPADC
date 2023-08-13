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
    @State var movidId : Int = 0
    
    let mBookingModel : MovieBookingModel = MovieBookingModelImpl.shared
    @State var banners : [BannerVO]? = nil
    @State var currentMovies : [MovieVO]? = nil
    @State var comingSoonMovies : [MovieVO]? = nil
    var cityId : Int
    var cityName : String
    
   
    var body: some View {
     //   NavigationStack{
        ScrollView{
            ZStack {
                
                //background
                Color(PRIMARY_COLOR)
                
                //body
                VStack(spacing:0.0) {
                    
                    //appbar
                    AppbarView(cityName: cityName)
                    
                    //promotion img slider
                    PromotionImgSliderView(banners: banners)
                    
                    //tab btn
                    TabBtnRowView(isActiveNowShowing: $isActiveNowShowing, isActiveComingSoon: $isActiveComingSoon)
                    
                    //nowshowing and coming soon grid
                    NowShowingAndComingSoonSection(isActiveComingSoon: $isActiveComingSoon,isShowing: $isShowing, movieId: $movidId, movies: (isActiveComingSoon ? comingSoonMovies : currentMovies) ?? [MovieVO]())
                    
                }.padding(.top,MARGIN_MEDIUM_3)
                
                
            }
        }
         
            
            
            .background(.black)
            .edgesIgnoringSafeArea([.bottom])
            .toolbar(.hidden)
            .navigationDestination(isPresented: $isShowing) {
                MovieDetailsScreen(isActiveComingSoon: isActiveComingSoon,movieId: movidId,cityId:cityId,cityName:cityName)
            }

            .onAppear{
                requestData()
            }
            //            .fullScreenCover(isPresented: $isShowing) {
            //                MovieDetailsScreen(isActiveComingSoon: $isActiveComingSoon)
            //            }
       // }
      
        
    }
    
    func requestData(){
        
        //get banners
        mBookingModel.getBanner { bannerVOs in
            self.banners = bannerVOs
            
        
        } onFailure: { error in
            
        }
        
        //get current movies
        mBookingModel.getMoviesCurrent { movies in
            self.currentMovies = movies
       
        } onFailure: { error in
            
        }
        
        //get coming soon movies
        mBookingModel.getMoviesComingSoon { movies in
            self.comingSoonMovies = movies
            //print("coming soon movies : \(comingSoonMovies ?? [MovieVO]())")
        } onFailure: { error in
            
        }
        
        

    }
    
}

struct MoviesScreen_Previews: PreviewProvider {
    static var previews: some View {
        MoviesScreen(cityId: 0,cityName: "")
    }
}



//img slider item
struct ImageSliderItemView: View {
    var imageUrl : String = ""
    
    init(imageUrl : String) {
        UIPageControl.appearance().pageIndicatorTintColor = .gray
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color(BTN_COLOR))
        self.imageUrl = imageUrl
    }

   
    
    var body: some View  {
        AsyncImage(url: URL(string: imageUrl)!) { phase in
            switch phase {
            case .empty:
                 ProgressView()
            case .success(let image):
                 image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, idealWidth: SLIDER_VIEW_WIDTH , maxWidth: SLIDER_VIEW_WIDTH , minHeight: 0, idealHeight: PROMOTION_IMG_HEIGHT , maxHeight: PROMOTION_IMG_HEIGHT)
                    .clipped()
            case .failure:
                Image(systemName: "exclamationmark.icloud")
                
            @unknown default:
                EmptyView()
            }
            
        }
    }
}


// promotion img slider
struct PromotionImgSliderView: View {
    var banners : [BannerVO]?
    var body: some View {
        TabView{
            
            ForEach(banners ?? [BannerVO]() ,id:\.id){
                banner in
                //img slider item
                ImageSliderItemView(imageUrl: banner.url ?? "")
                
            }
            
        }.tabViewStyle(.page)
        
            .frame(width:SLIDER_VIEW_WIDTH,height: SLIDER_VIEW_HEIGHT)
    }
}

//tab button view
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

//tag btn row
struct TabBtnRowView: View {
    @Binding var isActiveNowShowing:Bool
    @Binding var isActiveComingSoon:Bool
    
    var body: some View {
        ZStack{
            Color(PRIMARY_DARK_COLOR)
            HStack{
                //now showing tab button
                TabButtonView(isActive: $isActiveNowShowing,label:LABEL_NOWSHOWING)
                    .onTapGesture {
                        isActiveNowShowing = true
                        isActiveComingSoon = false
                       
                    }
                
                //coming soon tab button
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


//now showing and coming soon movie grid
struct NowShowingAndComingSoonSection: View {
    @Binding var isActiveComingSoon:Bool
    @Binding var isShowing: Bool
    
    @Binding var movieId : Int
    var movies : [MovieVO]
   
    var body: some View {
       
            
            LazyVGrid(columns: [GridItem(spacing: 0),
                                GridItem(spacing: 0)],spacing: 100) {
                ForEach(movies,id: \.id) { movie in
                        
                        //movie item
                        MovieItemView(isActiveComingSoon: $isActiveComingSoon,movie: movie)
                        .onTapGesture {
                           
                            self.movieId = movie.id ?? 0
                            print("movie screen : movie id \(movieId)")
                            isShowing = true
                            print(isShowing)

                        }
                   

                    
                }
                
            }.padding(.top, MARGIN_XLARGE)
                .padding(.bottom,UIScreen.main.bounds.height * 0.2)
        .padding(.top,MARGIN_XLARGE)
    }
}
