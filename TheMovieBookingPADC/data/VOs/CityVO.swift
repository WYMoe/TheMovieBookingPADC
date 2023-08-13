//
//  CityVO.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 28/07/2023.
//

import Foundation


struct CityVO : Codable,Hashable {
    var id : Int?
    var name : String?
    
    
    enum CodingKeys : String, CodingKey {
        case id
        case name
    }
}
