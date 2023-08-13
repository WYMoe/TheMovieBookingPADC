//
//  CheckoutRequestVO.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 03/08/2023.
//

import Foundation
struct CheckOutRequestVO: Codable {
    var cinema_day_timeslot_id: Int?
    var seat_number: String?
    var booking_date: String?
    var movie_id: Int?
    var payment_type_id: Int?
    var snacks: [SnackRequestVO]?
    
    enum CodingKeys: CodingKey {
        case cinema_day_timeslot_id
        case seat_number
        case booking_date
        case movie_id
        case payment_type_id
        case snacks
    }
    
}
