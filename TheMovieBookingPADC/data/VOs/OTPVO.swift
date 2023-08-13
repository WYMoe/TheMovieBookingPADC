//
//  OTPVO.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 27/07/2023.
//

import Foundation

struct OTPVO : Codable,Hashable {
   
    
    
    var code : Int?
    var message : String?
    
    
    enum CodingKeys : String, CodingKey {
        case code
        case message
    }
}
