//
//  TheMovieBookingPADCApp.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 04/05/2023.
//

import SwiftUI

@main
struct TheMovieBookingPADCApp: App {
    
    let mBookingModel = MovieBookingModelImpl.shared
    var body: some Scene {
        WindowGroup {
            ContentView(isActive: false).onAppear{
                mBookingModel.checkUser()
            }
        
             //MoviesScreen( cityId: 1, cityName: "")
            
        }
    }
}
