//
//  ApiConstants.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 28/07/2023.
//

import Foundation
let BASE_IMAGE_URL = "https://image.tmdb.org/t/p/w400"
let BASE_URL = "https://tmba.padc.com.mm"
let ENDPOINT_GET_OTP = "/api/v2/get-otp"
let ENDPOINT_CHECK_OTP = "/api/v2/check-otp"
let ENDPOINT_GET_CITIES = "/api/v2/cities"
let ENDPOINT_SET_CITIES = "/api/v2/set-city"
let ENDPOINT_GET_BANNERS = "/api/v2/banners"
let ENDPOINT_GET_MOVIES_CURRENT = "/api/v2/movies?status=current"
let ENDPOINT_GET_MOVIES_COMINGSOON = "/api/v2/movies?status=comingsoon"
let ENDPOINT_GET_MOVIE_DETAIL = "/api/v1/movies/"
let ENDPOINT_GET_CINEMA_AND_SHOWTIME = "/api/v2/cinema-day-timeslots?date="
let ENDPOINT_GET_SEATING_PLAN = "/api/v2/seat-plan?cinema_day_timeslot_id="
let ENDPOINT_SHOWTIME_PARAM = "&booking_date="
let ENDPOINT_GET_SNACK_CATEGORY = "/api/v2/snack-categories"
let ENDPOINT_GET_SNACKS = "/api/v2/snacks"
let ENDPOINT_GET_SNACKS_BY_CATEGORY = "/api/v2/snacks?category_id="
let ENDPOINT_GET_PAYMENT_TYPES = "/api/v2/payment-types"
let ENDPOINT_CHECKOUT = "/api/v2/checkout"
