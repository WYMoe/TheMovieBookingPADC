//
//  DateItemView.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 18/05/2023.
//

import SwiftUI
struct DateItemView: View {
    var date  : String
    @State var day : String = ""
    @State var month : String = ""
    @State var numOfDay : String = ""
    var isSelected : Bool

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            DateBackgroundView(isSelected : isSelected)
            
            VStack(spacing:0.0){
                Text(day)
                    .foregroundColor( .black)
                    .font(.system(size:MARGIN_MEDIUM_1))
                    .fontWeight(.medium)
                    
                
                Text(month)
                    .foregroundColor(.black)
                    .font((.system(size: MARGIN_MEDIUM_1)))
                    .fontWeight(.medium)
                    .padding(.top,MARGIN_MEDIUM)
                
                Text(numOfDay)
                    .foregroundColor(.black)
                    .font(.system(size:MARGIN_MEDIUM_2))
                    .fontWeight(.medium)
                    .padding(.top,MARGIN_SMALL)
                
            }
            
            .padding(.top,MARGIN_MEDIUM_3)
        }.frame(width: DATE_BACKGROUND_WIDTH,height: DATE_BACKGROUND_HEIGHT)
            .onAppear{
                getDayMonthYearName(from: date)
            }
            
    }
    func getDayMonthYearName(from dateString: String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-M-d"
        
        if let date = dateFormatter.date(from: dateString) {
            let dayNameFormatter = DateFormatter()
            dayNameFormatter.dateFormat = "E"
            self.day = dayNameFormatter.string(from: date)
            
            let monthNameFormatter = DateFormatter()
                monthNameFormatter.dateFormat = "MMM"
            self.month = monthNameFormatter.string(from: date)
            
            let dayNumberFormatter = DateFormatter()
                dayNumberFormatter.dateFormat = "d"
            self.numOfDay = dayNumberFormatter.string(from: date)
            
            
        }
        
        
    }
}

struct DateItemView_Previews: PreviewProvider {
    static var previews: some View {
        DateItemView(date: "",isSelected: false)
    }
}
