//
//  BannerVO.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 30/07/2023.
//

import Foundation
struct BannerVO : Codable, Hashable {
  
    
    var id : Int?
    var title : String?
    var url : String?
    var isActive : Int?
    var createdAt : String?
    var updatedAt : String?
    
    enum CodingKeys : String, CodingKey {
        case id
        case title
        case url
        case isActive = "is_active"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    
}
