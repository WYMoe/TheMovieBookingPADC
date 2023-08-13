//
//  CitiesResponse.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 28/07/2023.
//

import Foundation
struct CitiesResponse : Codable {
    var code : Int?
    var message : String?
    var data : [CityVO]?
    
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
        
    }
}
