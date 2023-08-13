//
//  MovieItemView.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 10/05/2023.
//

import SwiftUI

struct MovieItemView: View {
    @Binding var isActiveComingSoon:Bool
    var movie : MovieVO
    
    
    var body: some View {
        ZStack{
            Color(.black)
            VStack(alignment: .leading, spacing:0.0){
                ZStack(alignment:.topTrailing){
//
//                    Image("Movie")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 170,height: 212)
                    MovieImageView(imageUrl: "\(BASE_IMAGE_URL)\(movie.posterPath ?? "")" )
                   
               
                    
                    if isActiveComingSoon {
                        Text("8th \n AUG")
                            .foregroundColor(Color(PRIMARY_DARK_COLOR))
                            .padding(5)
                            .font(.system(size: 10))
                            .multilineTextAlignment(.center)
                            .background(Color(BTN_COLOR))
                            .cornerRadius(8)
                            .frame(width: 35,height: 35)
                            .padding(7)
                        
                    } else {
                        
                        
                      Text("")
                        
                        
                    }
                    LinearGradient(colors: [.clear,.clear,.clear,.black], startPoint: .top, endPoint: .bottom)
                    
                    
                    
                }
                
                
                
                HStack{
                    Text(movie.originalTitle ?? "")
                        .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 12))
                    
                    Spacer()
                    
                    Image("imdb")
                    Text("9.0")
                        .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                        .font(.system(size: 12))
                        .italic()
                        .fontWeight(.bold)
                    
                    
                    
                }.padding(.leading,7)
                    .padding(.trailing,7)
                
                HStack{
                    Text("U/A")
                        .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                    
                    
                    Circle()
                        .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                        .frame(width: 5,height: 5)
                    
                    Text("2D, 3D, IMAX") .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                        .font(.system(size: 10))
                    
                    
                    
                }.padding(.leading,7)
                    .padding(.trailing,7)
                
            }.padding(.bottom,22)
            
            
            
            
            
        }.frame(width: 170,height: 212)
        
        
    }
}

struct MovieItemView_Previews: PreviewProvider {
    static var previews: some View {
        MovieItemView(isActiveComingSoon: .constant(false),movie: MovieVO())
    }
}


struct MovieImageView: View {
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
                   // .frame(minWidth: 170, idealWidth: 170 , maxWidth: 170 , minHeight: 210, idealHeight: 210 , maxHeight: 210)

                    //.frame(minWidth: 0, idealWidth: 170 , maxWidth: 170 , minHeight: 0, idealHeight: 212 , maxHeight: 212)
                    .frame(width:170,height: 212)
                    .clipped()
            case .failure:
                Image(systemName: "exclamationmark.icloud")
                
            @unknown default:
                EmptyView()
            }
            
        }
    }
}
