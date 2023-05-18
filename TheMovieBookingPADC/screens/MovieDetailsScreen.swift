//
//  NowShowingDetailsScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 11/05/2023.
//

import SwiftUI
import AVKit






struct MovieDetailsScreen: View {
    @Binding  var isActiveComingSoon:Bool
    @Environment(\.dismiss) var dismiss
    var body: some View {
        //NavigationStack
        NavigationStack {
            
            // zstack
            ZStack {
                Color(.black)
                
                //vstack
                VStack(spacing:0.0){
                    ScrollView{
                        //video player and poster
                        VideoPlayerAndPosterSection(){
                            dismiss()
                        }
                        
                        //labels
                        MovieLabelsView()
                        
                        //spacer
                        Spacer()
                        
                        
                        //info section
                        MovieInfoSection()
                        
                        //setNotification section
                        if isActiveComingSoon {
                            SetNotificationSection()
                            
                        }
                        
                        //story line
                        StorylineSection()
                        
                        
                        // cast section
                        CastSection()
                    }
                    
                    
                }
                
                .safeAreaInset(edge: .bottom) {
                   
                    if(!isActiveComingSoon){
                    NavigationLink {
                        TimeSlotScreen()
                    } label: {
                        
                        //btn
                       
                            BottomPinButtonView(label: LABEL_BOOKING_BTN)
                    }.buttonStyle(.plain)
                       
                        
                    }
                   
                    
                    
                }
                .padding(.top,20)
               
            } .edgesIgnoringSafeArea([.top,.bottom])
                
            
            
        }
       
        .navigationBarBackButtonHidden(true)
            
    }
}

struct MovieDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsScreen(isActiveComingSoon: .constant(false))
    }
}


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

struct VideoPlayerAndPosterSection: View {
    var onTapBack : () -> Void = { }
    var body: some View {
        ZStack(alignment: .bottomLeading){
            //video player, back button and share button
            VideoplayerBackButtonAndShareButtonView(){
                onTapBack()
            }
            
            //poster img
            Image("Movie")
                .resizable()
                .frame(width: MOVIE_POSTER_WIDTH,height: MOVIE_POSTER_HEIGHT)
                .aspectRatio( contentMode: .fill)
                .padding(.leading,MARGIN_MEDIUM)
                .offset(y: MOVIE_POSTER_OFFSET_Y)
            
        }
    }
}

struct MovieLabelsView: View {
    var body: some View {
        VStack(alignment:.leading,spacing: 10.0){
            //movie title and imdb rating row
            HStack {
                //title
                Text("Venom")
                    .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                    .multilineTextAlignment(.leading)
                    .font(.system(size: TEXT_REGULAR_2X))
                
                
                //imdb rating
                Image("imdb")
                Text("9.0")
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
            MovieGenreView()
            
            
            
            
            
        }.padding(EdgeInsets(top: MARGIN_MEDIUM_3, leading: UIScreen.main.bounds.width * 0.35, bottom: 0, trailing: 0))
    }
}

struct MovieInfoSection: View {
    var body: some View {
        HStack(spacing:50){
            
            //Censor Rating
            MovieInfoColumnView(label: LABEL_CENSOR_RATING,value: "U/A")
            
            //Release Date
            MovieInfoColumnView(label: LABEL_RELEASE_DATE,value: "May 8th 2023")
            
            //Duration
            MovieInfoColumnView(label: LABEL_DURATION,value: "2hr 15min")
        }.frame(width: UIScreen.main.bounds.width,height: MARGIN_XXLARGE)
            .padding(.top,UIScreen.main.bounds.height * 0.08)
    }
}

struct StorylineSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing:20.0) {
            
            //title
            Text(LABEL_STORYLINE)
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: TEXT_REGULAR))
                .fontWeight(.bold)
            
            //description
            Text("In the 1970s, young Gru tries to join a group of supervillains called the Vicious 6 after they oust their leader -- the legendary fighter Wild Knuckles. When the interview turns disastrous, Gru and his Minions go on the run with the Vicious 6 hot on their tails. Luckily, he finds an unlikely source for guidance -- Wild Knuckles himself -- and soon discovers that even bad guys need a little help from their friends.")
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .font(.system(size: TEXT_REGULAR))
                .fontWeight(.bold)
            
        }
        .padding([.top,.bottom],MARGIN_XLARGE)
        .padding([.leading,.trailing],MARGIN_MEDIUM)
    }
}

struct CastSection: View {
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
                    ForEach(1...10,id:\.self){
                        _ in
                        
                        CastCircleImgView(castName: "cast")
                    }
                }
                
                
                
            }
        }.padding([.leading,.trailing],MARGIN_MEDIUM)
    }
}



struct MovieGenreView: View {
    var body: some View {
        HStack{
            
           
            
            
            
            LazyHGrid(rows: [GridItem(spacing:20),GridItem()]) {
                //genres
                ForEach(1...5,id:\.self){
                    _ in
                    //chip
                    GenreChipItemView(genre: "Action")
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



struct SetNotificationSection: View {
    
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

struct CastCircleImgView: View {
    var castName:String = ""
    var body: some View {
        Image(castName)
            .resizable()
            .frame(width: MARGIN_XXLARGE,height:MARGIN_XXLARGE)
            .cornerRadius(MARGIN_XXLARGE)
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
