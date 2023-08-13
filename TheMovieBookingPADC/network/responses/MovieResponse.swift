//
//  MovieResponse.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 30/07/2023.
//

import Foundation
struct MovieResponse : Codable {
    var code : Int?
    var message : String?
    var data : [MovieVO]?
    
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
        
    }
}
