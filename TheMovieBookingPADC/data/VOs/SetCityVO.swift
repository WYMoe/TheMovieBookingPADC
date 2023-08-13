//
//  SetCityVO.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 28/07/2023.
//

import Foundation

struct SetCityVO : Codable,Hashable {
    var code : Int?
    var message : String?
    
    
    enum CodingKeys : String, CodingKey {
        case code
        case message
    }
}
