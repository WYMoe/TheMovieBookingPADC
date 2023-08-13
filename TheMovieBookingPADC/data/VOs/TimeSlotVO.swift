//
//  TimeSlotVO.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 01/08/2023.
//

import Foundation

struct TimeSlotVO : Codable, Hashable {
    
    var cinemaDayTimeSlotId : Int?
    var startTime : String?
    var status : Int?
    
    enum CodingKeys: String, CodingKey {
        case cinemaDayTimeSlotId = "cinema_day_timeslot_id"
        case startTime = "start_time"
        case status
        
    }
    
   
}
