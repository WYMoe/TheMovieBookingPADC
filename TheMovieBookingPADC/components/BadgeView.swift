//
//  BadgeView.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 15/05/2023.
//

import SwiftUI

struct BadgeView: View {
    let count: Int

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.clear
            Text(String(count))
                .font(.system(size: 12))
                .padding(5)
                .background(Color.red)
                .clipShape(Circle())

        }
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView(count: 5)
    }
}
