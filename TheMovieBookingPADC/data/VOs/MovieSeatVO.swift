//
//  MovieSeatVO.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 19/05/2023.
//

import Foundation



struct MovieSeatVO : Codable,Hashable{
    var idForGrid : String = UUID().uuidString
    var id: Int?
    var text: String?
    var type: String?
    var seatName : String?
    var symbol : String?
    var price : Int?
    var isSelected : Bool = false
    
    
    enum CodingKeys : String, CodingKey {
        case id
        case text
        case type
        case seatName = "seat_name"
        case symbol
        case price
    }
    func isAvailable() -> Bool {
        return type == SEAT_TYPE_AVAILABLE
    }
    
    func isTaken() -> Bool {
        return type == SEAT_TYPE_TAKEN
    }
    
    
    func isSpace() -> Bool {
        return type == SEAT_TYPE_SPACE
    }
    func isText() -> Bool {
        return type == SEAT_TYPE_TEXT
    }
    
    
}

let SEAT_TYPE_AVAILABLE = "available"
let SEAT_TYPE_TAKEN = "taken"
let SEAT_TYPE_SPACE = "space"
let SEAT_TYPE_TEXT = "text"
