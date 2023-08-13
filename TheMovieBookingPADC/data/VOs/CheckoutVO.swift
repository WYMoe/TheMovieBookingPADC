//
//  CheckoutVO.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 03/08/2023.
//

import Foundation
struct CheckoutVO : Codable {

    var id : Int?
    var bookingNo : String?
    var bookingDate : String?
    var row : String?
    var seat : String?
    var totalSeat : Int?
    var total : String?
    var movieId : Int?
    var cinemaId : Int?
    var username : String?
    var timeslot : TimeSlotVO?
    var snacks : [SnackVO]?
    var qrcode : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case bookingNo = "booking_no"
        case bookingDate = "booking_date"
        case row
        case seat
        case totalSeat = "total_seat"
        case total
        case movieId = "movie_id"
        case cinemaId = "cinema_id"
        case username
        case timeslot
        case snacks
        case qrcode = "qr_code"
    }
   
    
    

    
  
    
    
    
 
}
