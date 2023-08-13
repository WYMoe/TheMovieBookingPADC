//
//  NowShowingDetailsScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 11/05/2023.
//

import SwiftUI
import AVKit


struct MovieDetailsScreen: View {
    var isActiveComingSoon:Bool
    @Environment(\.dismiss) var dismiss
    @State var isPresented : Bool = false
    var movieId : Int
    
    @State var movieDetail : MovieDetailVO? = nil
    let mBookingModel : MovieBookingModel = MovieBookingModelImpl.shared
    var cityId : Int
    var cityName : String
    var body: some View {
        

            
         
            ZStack {
                
                //background
                Color(.black)
                
                //body
                
                VStack(spacing:0.0){
                    ScrollView(showsIndicators: false){
                        //video player and movie poster
                        VideoPlayerAndMoviePosterView(onTapBack: {
                            dismiss()
                        }, movieDetail: movieDetail)
                        
                        //labels
                        MovieLabelsView(movieDetail : movieDetail )
                        
                        //spacer
                        Spacer()
                        
                        
                        //info view
                        MovieInfoView(movieDetail: movieDetail)
                        
                        //setNotification view
                        if isActiveComingSoon {
                            SetNotificationView()
                            
                        }
                        
                        //storyline
                        StorylineView(movieDetail: movieDetail)
                        
                        
                        // cast
                        CastView(movieDetail: movieDetail)
                        
                        if isActiveComingSoon {
                            Spacer(minLength: 30)
                        }
                    }
                    
                    
                }
                
                .safeAreaInset(edge: .bottom) {
                   
                    if(!isActiveComingSoon){

                        BottomPinButtonView(label: LABEL_BOOKING_BTN)
                            .padding(.bottom,MARGIN_MEDIUM_3)
                            .onTapGesture {
                                self.isPresented = true
                            }
                        
            
                        
                    }
                   
                    
                    
                }
                .padding(.top,20)
               
            } .edgesIgnoringSafeArea([.top,.bottom])
            .navigationDestination(isPresented: $isPresented, destination: {
                TimeSlotScreen( timeslot: TimeSlotVO(),movieTitle: movieDetail?.originalTitle ?? "",cinemaForCheckout: "",screenStatus: 0,movieId: movieId,cityId:cityId,cityName: cityName)
            })
              .navigationBarBackButtonHidden(true)
              .onAppear{
                  requestData()
              }
            
    }
    
    func requestData(){
        mBookingModel.getMovieDetail(movieId: movieId) { movieDetail in
            
            self.movieDetail = movieDetail
        } onFailure: { error in
            print(error.localizedDescription)
        }

        
    }
}

struct MovieDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsScreen(isActiveComingSoon: false,movieId: 0, cityId: 0, cityName: "")
    }
}


//video player and back button, share button
struct VideoPlayerAndBackButtonView: View {
   
    var onTapBack : () -> Void = { }
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            
            //video player
            VideoPlayer(player: AVPlayer(url: URL(string: SAMPLE_VIDEO_URL)!))
                .frame(height: VIDEO_PLAYER_HEIGHT)
            
            
            //btn row
            HStack{
                //back button
                Button(action: {
                    onTapBack()
                  
                }) {
                    Image(systemName: IC_BACK)
                        .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                        .frame(width: MARGIN_LARGE,height: MARGIN_LARGE)
                        .padding(.leading,MARGIN_LARGE)
                        .padding(.top,MARGIN_XXLARGE)
                }
                
                //spacer
                Spacer()
                
                //share button
                Button(action: {
                    
                    
                }) {
                    Image(IC_SHARE)
                        .frame(width: MARGIN_LARGE,height: MARGIN_LARGE)
                        .padding(.trailing,MARGIN_XLARGE)
                        .padding(.top,MARGIN_XXLARGE)
                }
            }
            
            
            
            
        }
    }
}


//video player and poster 
struct VideoPlayerAndMoviePosterView: View {
    
    var onTapBack : () -> Void = { }
    var movieDetail : MovieDetailVO? = nil
    var body: some View {
        
        
        ZStack(alignment: .bottomLeading){
            //video player, back button and share button
            VideoplayerBackButtonAndShareButtonView(){
                onTapBack()
            }
            
            
            
            //poster img
                AsyncImage(url: URL(string: "\(BASE_IMAGE_URL)\(movieDetail?.posterPath ?? "")")!) { phase in
                switch phase {
                case .empty:
                     ProgressView()
                case .success(let image):
                     image
                        .resizable()
                        
                        .frame(minWidth: 0, idealWidth: MOVIE_POSTER_WIDTH , maxWidth: MOVIE_POSTER_WIDTH , minHeight: 0, idealHeight: MOVIE_POSTER_HEIGHT , maxHeight: MOVIE_POSTER_HEIGHT)
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .padding(.leading,MARGIN_MEDIUM)
                        .offset(y: MOVIE_POSTER_OFFSET_Y)
                case .failure:
                    Image(systemName: "exclamationmark.icloud")

                @unknown default:
                    EmptyView()
                }

            }
            
        }
    }
}


//movie label
struct MovieLabelsView: View {
    var movieDetail : MovieDetailVO? = nil
    var body: some View {
        VStack(alignment:.leading,spacing: 10.0){
            //movie title and imdb rating row
            HStack {
                //title
                Text(movieDetail?.originalTitle ?? "")
                    
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                    .multilineTextAlignment(.leading)
                   
                    
                    .font(.system(size: TEXT_REGULAR_2X))
                
                
                //imdb rating
                Image("imdb")
                Text("\(String(format:"%.1f",movieDetail?.rating ?? 0.0))")
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                    .font(.system(size: TEXT_REGULAR_2X))
                    .italic()
                    .fontWeight(.bold)
                
            }
            
            //cinema type
            Text("2D, 3D, IMAX, 3D BOX")
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .multilineTextAlignment(.leading)
                .font(.system(size: TEXT_REGULAR_2X))
                .padding(.bottom,MARGIN_CARD_MEDIUM_2)
            
            
            //genre
            MovieGenreView(movieDetail: movieDetail)
            
            
            
            
            
        }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width * 0.4, bottom: 0, trailing: 0))
    }
}


//movie info view
struct MovieInfoView: View {
    var movieDetail : MovieDetailVO? = nil
    var body: some View {
        HStack(spacing:50){
            
            //Censor Rating
            MovieInfoColumnView(label: LABEL_CENSOR_RATING,value: "U/A")
            
            //Release Date
            MovieInfoColumnView(label: LABEL_RELEASE_DATE,value: movieDetail?.releaseDate ?? "")
            
            //Duration
            MovieInfoColumnView(label: LABEL_DURATION,value: "\(movieDetail?.runtime ?? 0) mins")
        }.frame(width: UIScreen.main.bounds.width,height: MARGIN_XXLARGE)
            .padding(.top,UIScreen.main.bounds.height * 0.08)
    }
}

//storyline
struct StorylineView: View {
    var movieDetail : MovieDetailVO? = nil
    var body: some View {
        VStack(alignment: .leading, spacing:20.0) {
            
            //title
            Text(LABEL_STORYLINE)
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: TEXT_REGULAR))
                .fontWeight(.bold)
            
            //description
            Text(movieDetail?.overview ?? "")
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: TEXT_REGULAR))
                .fontWeight(.bold)
            
        }
        .padding([.top,.bottom],MARGIN_XLARGE)
        .padding([.leading,.trailing],MARGIN_MEDIUM)
    }
}


//cast
struct CastView: View {
    var movieDetail : MovieDetailVO? = nil
    var body: some View {
        VStack(alignment:.leading,spacing: 20.0){
            //title
            Text(LABEL_CAST)
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: TEXT_REGULAR))
                .fontWeight(.bold)
            
            //cast imgs
            ScrollView(.horizontal){
                
                HStack(spacing:20) {
                    ForEach(movieDetail?.casts ?? [CastVO](),id:\.self){
                        cast in
                        
                        //cast img item
                        CastCircleImgItemView(castProfilePath: cast.profilePath ?? "")
                    }
                }
                
                
                
            }
        }.padding([.leading,.trailing],MARGIN_MEDIUM)
    }
}



struct MovieGenreView: View {
    var movieDetail : MovieDetailVO? = nil
    var body: some View {
        HStack{
            
           
            
            
            
            LazyHGrid(rows: [GridItem(spacing:20),GridItem()]) {
                //genres
                ForEach(movieDetail?.genres ?? [String](),id:\.self){
                    genre in
                    //chip
                    GenreChipItemView(genre: genre)
                }
            }
            
            
            
        }
    }
}

struct MovieInfoColumnView: View {
    var label:String = ""
    var value: String = ""
    var body: some View {
        VStack(spacing:10.0){
            //label
            Text(label)
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: TEXT_SMALL))
                .fontWeight(.bold)
            //value
            Text(value)
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: TEXT_REGULAR))
                .fontWeight(.heavy)
        }
    }
}



struct SetNotificationView: View {
    
    var body: some View {
        HStack(spacing:5){
            
            //labels
            VStack(alignment:.leading, spacing:15.0){
                //releasing in
                Text("Releasing in 5 days")
                    .font(.system(size: TEXT_REGULAR_2X))
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                    .fontWeight(.heavy)
                //get notify
                Text(LABEL_GET_NOTIFY)
                    .font(.system(size: TEXT_REGULAR))
                    .foregroundColor(Color(PRIMARY_DARK_COLOR))
                    .fontWeight(.bold)
                
                
                //button
                SetNotificationBtnView()
                
            }
            
            //vector img
            Image(IC_MAN_SITTING)
            
        }
        
        .frame(width: UIScreen.main.bounds.width*0.98,height: 155)
        .background(.gray)
        .cornerRadius(CORNER_RADIUS_MEDIUM)
        .padding(.top,MARGIN_XLARGE)
        
    }
}

struct SetNotificationBtnView: View {
    var body: some View {
        HStack{
            
            //ic_bell
            Image(systemName: IC_BELL)
                .resizable()
                .frame(width: MARGIN_MEDIUM_2,height: MARGIN_MEDIUM_2)
            //label
            Text(LABEL_SET_NOTIFIACTION_BTN)
        }.frame(width: UIScreen.main.bounds.width * 0.45, height: MARGIN_XLARGE+5)
            .background(Color(BTN_COLOR))
            .cornerRadius(CORNER_RADIUS_MEDIUM)
    }
}

struct GenreChipItemView: View {
    var genre:String = ""
    var body: some View {
        Text(genre)
            .font(.system(size: TEXT_SMALL))
            .padding(MARGIN_SMALL)
            .background(Color(BTN_COLOR))
            .cornerRadius(GENRE_CHIP_CORNER_RADIUS)
    }
}

struct CastCircleImgItemView: View {
    var castProfilePath:String = ""
    var body: some View {

        
        AsyncImage(url: URL(string: "\(BASE_IMAGE_URL)\(castProfilePath)")!) { phase in
        switch phase {
        case .empty:
             ProgressView()
        case .success(let image):
             image
                .resizable()
                
                .frame(width: MARGIN_XXXLARGE,height:MARGIN_XXXLARGE)
                .cornerRadius(MARGIN_XXLARGE)
                
                
             
        case .failure:
            Image(systemName: "exclamationmark.icloud")

        @unknown default:
            EmptyView()
        }

    }

    }
}

struct VideoplayerBackButtonAndShareButtonView: View {
    var onTapBack:()->Void = {
        
    }
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            
            //video player
            VideoPlayer(player: AVPlayer(url: URL(string: SAMPLE_VIDEO_URL)!))
                .frame(height: VIDEO_PLAYER_HEIGHT)
            
            
            //btn row
            HStack{
                //back button
                Button(action: {
                    onTapBack()
                    
                }) {
                    Image(systemName: IC_BACK)
                        .resizable()
                        .frame(width: MARGIN_CARD_MEDIUM_2,height: MARGIN_MEDIUM_3)
                        .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                        .padding(.leading,MARGIN_MEDIUM_3)
                        .padding(.top,MARGIN_XXLARGE)
                }
                
                Spacer()
                
                //share button
                Button(action: {
                    
                    
                }) {
                    Image(IC_SHARE)
                        .frame(width: MARGIN_LARGE,height: MARGIN_LARGE)
                        .padding(.trailing,MARGIN_MEDIUM_3)
                        .padding(.top,MARGIN_XXLARGE)
                }
            }
            
            
            
            
        }
    }
}
