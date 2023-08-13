//
//  CinemaVO.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 01/08/2023.
//

import Foundation

struct CinemaVO : Codable, Hashable {
    
    var cinemaId : Int?
    var cinema : String?
    var timeslots : [TimeSlotVO]?


    enum CodingKeys: String, CodingKey {
        case cinemaId = "cinema_id"
        case cinema
        case timeslots

    }
    
}
