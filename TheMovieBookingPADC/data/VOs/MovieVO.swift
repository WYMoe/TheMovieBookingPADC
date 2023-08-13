//
//  MovieVO.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 30/07/2023.
//

import Foundation
struct MovieVO : Codable, Hashable {

    
    var id : Int?
    var originalTitle : String?
    var releaseDate : String?
    var genres : [String]?
    var posterPath : String?
    
    enum CodingKeys : String, CodingKey {
        case id
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case genres
        case posterPath = "poster_path"
   
    }
    
}
