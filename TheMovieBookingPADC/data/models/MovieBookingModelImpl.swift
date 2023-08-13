//
//  MovieBookingModelImpl.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 28/07/2023.
//

import Foundation

struct MovieBookingModelImpl : MovieBookingModel {
    
    
    static let shared = MovieBookingModelImpl()

    
    private init(){
        
    }
    
    //data agent
    let mBookingDataAgent : MovieBookingDataAgent = MovieBookingDataAgentImpl.shared
    
    //dao
    let mUserDAO = UserDAO.shared
    
    func getOTP(phoneNumber: String, onSuccess: @escaping (OTPVO) -> Void, onFailure: @escaping (Error) -> Void) {
        mBookingDataAgent.getOTP(phoneNumber: phoneNumber, onSuccess: {
            otpvo in
            onSuccess(otpvo)
        }, onFailure: onFailure)
    }
    
    func signInAndGetUserInfo(phoneNumber : String, otp : String, onSuccess : @escaping(UserResponse) -> Void, onFailure: @escaping (Error) -> Void){
        mBookingDataAgent.signInAndGetUserInfo(phoneNumber: phoneNumber, otp: otp, onSuccess: {  userResponse in
            onSuccess(userResponse)
            
            let userObject = UserObject()
            
            userObject.id = userResponse.data?.id
            userObject.message = userResponse.data?.message
            userObject.email = userResponse.data?.email
            userObject.phone = userResponse.data?.phone
            userObject.totalExpense = userResponse.data?.totalExpense
            userObject.profileImage = userResponse.data?.profileImage
            userObject.token = userResponse.token
            
           //to do :: add uservo to realm
           mUserDAO.saveUserInfo(userInfo: userObject)
            
            
            
        } , onFailure: onFailure)
    }
    
    //get cities
    func getCities(onSuccess: @escaping ([CityVO]) -> Void, onFailure: @escaping (Error) -> Void){
        mBookingDataAgent.getCities(onSuccess: {
            cities in
            onSuccess(cities)
        }, onFailure: onFailure)

    }
    
    //set city
    
    func setCity(token: String,cityId:Int,onSuccess: @escaping (SetCityVO) -> Void, onFailure: @escaping (Error) -> Void){
        mBookingDataAgent.setCity(token: token, cityId: cityId, onSuccess: { setCityVO in
            onSuccess(setCityVO)
        } , onFailure: onFailure)

    }

    //get banners
    
    func getBanner(onSuccess: @escaping ([BannerVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mBookingDataAgent.getBanner { banners in
            onSuccess(banners)
        } onFailure: { error in
            onFailure(error)
        }

    }
    
    // get current movie
    func getMoviesCurrent(onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mBookingDataAgent.getMoviesCurrent { movies in
            onSuccess(movies)
        } onFailure: { error in
            onFailure(error)
        }

    }
    
    //get coming soon model
    func getMoviesComingSoon(onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mBookingDataAgent.getMoviesComingSoon { movies in
            onSuccess(movies)
        } onFailure: { error in
            onFailure(error)
        }

    }
    
    //get movie detail
    func getMovieDetail(movieId: Int, onSuccess: @escaping (MovieDetailVO) -> Void, onFailure: @escaping (Error) -> Void) {
        mBookingDataAgent.getMovieDetail(movieId: movieId) { movieDetail in
            onSuccess(movieDetail)
        } onFailure: { error in
            onFailure(error)
        }

    }
    
    //get cinema and showtime
    func getCinemaAndShowtime(token: String, date: String, onSuccess: @escaping ([CinemaVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mBookingDataAgent.getCinemaAndShowtime(token: token, date: date) { cinemas in
            onSuccess(cinemas)
        } onFailure: { error in
            onFailure(error)
        }

    }
    
    //get seating plan
    
    func getSeatingPlanByShowtime(token: String,timeslotId: Int, date: String, onSuccess: @escaping ([MovieSeatVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mBookingDataAgent.getSeatingPlanByShowtime(token: token, timeslotId: timeslotId, date: date) { movieSeatArrs in
            
            let movieSeats : [MovieSeatVO] = movieSeatArrs.compactMap { $0 }.flatMap { $0 }
            onSuccess(movieSeats)
        } onFailure: { error in
            
        }

    }
    
    //get snack category
    func getSnackCategory(token: String, onSuccess: @escaping ([SnackCategoryVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        
        mBookingDataAgent.getSnackCategory(token: token) { snackCategory in
            onSuccess(snackCategory)
        } onFailure: { error in
            onFailure(error)
        }

    }
    
    //get snacks
    
    func getSnacks(token: String, onSuccess: @escaping ([SnackVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mBookingDataAgent.getSnacks(token: token) { snacks in
            onSuccess(snacks)
        } onFailure: { error in
            onFailure(error)
        }

    }
    
    func getSnacksByCategory(categoryId:Int, token: String, onSuccess: @escaping ([SnackVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mBookingDataAgent.getSnacksByCategory(categoryId: categoryId, token: token) { snacks in
            onSuccess(snacks)
        } onFailure: { error in
            onFailure(error)
        }


    }
    
    //get payment types
    func getPaymentTypes(token: String, onSuccess: @escaping ([PaymentTypeVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mBookingDataAgent.getPaymentTypes(token: token) { payments in
            onSuccess(payments)
        } onFailure: { error in
            onFailure(error)
        }

    }
    
    //checkout
    
    func checkout(token: String, timeslotId: Int, seatName: String, date: String, movieId: Int, paymentId: Int, snacks: [SnackRequestVO], onSuccess: @escaping (CheckoutVO) -> Void, onFailure: @escaping (Error) -> Void) {
        mBookingDataAgent.checkout(token: token, timeslotId: timeslotId, seatName: seatName, date: date, movieId: movieId, paymentId: paymentId, snacks: snacks) { checkoutData in
            onSuccess(checkoutData)
        } onFailure: { error in
            onFailure(error)
        }

    }
   
    //database
    func getUser() -> UserVO {
        return mUserDAO.getUserInfo() ?? UserVO()
    }
    
    func checkUser() -> UserVO {
        return mUserDAO.checkUser() ?? UserVO()
    }
}

