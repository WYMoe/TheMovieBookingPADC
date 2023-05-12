//
//  NowShowingDetailsScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 11/05/2023.
//

import SwiftUI
import AVKit



let SAMPLE_VIDEO_URL = "https://jsoncompare.org/LearningContainer/SampleFiles/Video/MP4/sample-mp4-file.mp4"

let SAMPLE_DESCRIPTION = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non tincidunt mauris, sit amet venenatis metus. Aliquam erat volutpat. Cras ut nunc nisi. Phasellus vel sapien felis. In hac habitasse platea dictumst. Cras congue augue id neque feugiat, a dignissim ex tincidunt. Morbi non faucibus velit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nullam porta ex lectus, eu consequat eros condimentum in. Integer rhoncus felis eget est vehicula, et laoreet nunc venenatis. Integer convallis feugiat quam, vitae porttitor elit tempus at. Vestibulum eu erat sed neque sagittis malesuada quis condimentum lacus. Praesent quis tristique neque. Pellentesque faucibus ullamcorper porta.\n Proin ac metus odio. Donec eget nibh ornare, viverra lectus sed, molestie lacus. Donec sit amet auctor ipsum. Pellentesque sit amet lectus quis enim congue imperdiet sit amet sit amet erat. Duis vitae magna tincidunt, faucibus ligula vitae, gravida dolor. Phasellus volutpat convallis eros, euismod vestibulum quam maximus et. Sed non felis non lectus placerat viverra in sit amet nulla. Etiam non placerat metus. Nullam efficitur sit amet dolor condimentum pharetra. Aliquam nec augue commodo, lobortis tortor et, dictum arcu. Proin dignissim tincidunt magna, ac viverra neque vehicula non. Vivamus vulputate imperdiet turpis, et fringilla est sagittis eu. Aliquam eget dolor elit. Ut facilisis condimentum venenatis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Proin pulvinar eros nulla, sed congue diam ornare non.\nInteger vel iaculis nisi. Duis posuere dui massa, ut malesuada tortor interdum in. Quisque rutrum dolor viverra lorem tincidunt, vitae feugiat lectus mattis. Nullam a quam id velit congue aliquam in et dolor. Nullam sed molestie ipsum. Morbi eu ipsum id velit tincidunt dictum. Phasellus a nisl eleifend, placerat diam pharetra, sodales sapien. Morbi vel diam nunc. Curabitur et dolor id tellus mollis elementum id convallis odio. Curabitur rhoncus porttitor dui, sed efficitur massa sagittis nec. Proin commodo mattis lacus, eu rutrum risus luctus ac. Curabitur pretium sollicitudin lacus, eu accumsan enim imperdiet eget. Integer iaculis et magna et rhoncus. Proin at tristique nisi."


struct NowShowingDetailsScreen: View {
    var body: some View {
        ZStack{
            Color(PRIMARY_COLOR)
            VStack(spacing:0.0){
                //video player and poster
                ZStack(alignment: .bottomLeading){
                    VideoPlayerAndBackButtonView()
                    
                    //HStack{
                    Image("Movie")
                        .resizable()
                        .frame(width: 140,height: 175)
                        .aspectRatio( contentMode: .fill)
                        .padding(.leading,17)
                        .offset(y: 160)
                       
                }
                    
                //labels
                VStack(alignment:.leading,spacing: 10.0){
                      
                        HStack {
                           
                            Text("Venom")
                                .foregroundColor(Color(PRIMAYR_LIGHT_COLOR))
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 16))
                               
                            
                            
                            Image("imdb")
                               // .offset(y: 160)
                            Text("9.0")
                                .foregroundColor(Color(PRIMAYR_LIGHT_COLOR))
                                .font(.system(size: 16))
                                .italic()
                                .fontWeight(.bold)
                                
                        }
                    HStack {
                        Text("2D, 3D, IMAX, 3D BOX")
                            .foregroundColor(Color(PRIMAYR_LIGHT_COLOR))
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 17))
                           
                    }
                    
                    HStack{
                        Text("Action")
                            .font(.system(size: 12))
                            .padding(5)
                            .background(Color(BTN_COLOR))
                            .cornerRadius(10)
                            
                        Text("Action")
                            .font(.system(size: 12))
                            .padding(5)
                            .background(Color(BTN_COLOR))
                            .cornerRadius(10)
                        Text("Action")
                            .font(.system(size: 12))
                            .padding(5)
                            .background(Color(BTN_COLOR))
                            .cornerRadius(10)
                      
                    }
                    
                    
                    
                    
                    
                }.padding(EdgeInsets(top: 20, leading: UIScreen.main.bounds.width * 0.25, bottom: 0, trailing: 0))
               
            }
         
        }.edgesIgnoringSafeArea([.top,.bottom])
    }
}

struct NowShowingDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NowShowingDetailsScreen()
    }
}


struct VideoPlayerAndBackButtonView: View {
    
   // var onTapBack : () -> Void = { }
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            
            
            VideoPlayer(player: AVPlayer(url: URL(string: SAMPLE_VIDEO_URL)!))
                .frame(height: 300)
            
            //back button
            Button(action: {
         //       onTapBack()
                
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .frame(width: 24,height: 24)
                    .padding(.leading,24.0)
                    .padding(.top,48.0)
            }
        }
    }
}
