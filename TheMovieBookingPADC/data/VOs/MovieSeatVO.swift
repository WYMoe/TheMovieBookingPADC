//
//  MovieSeatVO.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 19/05/2023.
//

import Foundation


struct MovieSeatVO{
    
    var id: String = UUID().uuidString
    var text: String = ""
    var type: String = ""
    
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

let SEAT_TYPE_AVAILABLE = "Available"
let SEAT_TYPE_TAKEN = "Taken"
let SEAT_TYPE_SPACE = "Space"
let SEAT_TYPE_TEXT = "Text"
