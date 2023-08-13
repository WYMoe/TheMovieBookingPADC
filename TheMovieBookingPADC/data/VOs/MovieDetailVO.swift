//
//  MovieDetailVO.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 30/07/2023.
//

import Foundation
struct MovieDetailVO : Codable, Hashable {

    
    var id : Int?
    var originalTitle : String?
    var releaseDate : String?
    var genres : [String]?
    var overview : String?
    var rating : Double?
    var runtime : Int?
    var posterPath : String?
    var casts : [CastVO]?
    
    enum CodingKeys : String, CodingKey {
        case id
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case genres
        case overview
        case rating
        case runtime
        case posterPath = "poster_path"
        case casts
   
    }
    
}
