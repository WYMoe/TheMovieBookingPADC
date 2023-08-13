//
//  SnackVO.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 15/05/2023.
//

import Foundation


struct SnackVO : Codable, Hashable {
    
   
    var id : Int?
    var name : String?
    var description : String?
    var price : Int?
    var categoryId : Int?
    var image : String?
    var quantity : Int? = 0
    var totalPrice : Int?
    
    enum CodingKeys: String,CodingKey {
        case id
        case name
        case description
        case price
        case categoryId
        case image
        //case quantity
        case totalPrice = "total_price"
        
    }
    
    
}
