//
//  CinemaAndShowtimeResponse.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 31/07/2023.
//

import Foundation
struct CinemaAndShowtimeResponse : Codable {
    var code : Int?
    var message : String?
    var data : [CinemaVO]?


    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data

    }
    
  
}
