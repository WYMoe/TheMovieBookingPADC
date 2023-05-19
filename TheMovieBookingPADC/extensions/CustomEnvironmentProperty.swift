//
//  CustomEnvironmentProperty.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 20/05/2023.
//

import Foundation
import SwiftUI

//
//struct RootPresentationKey : EnvironmentKey {
//    static let defaultValue: Binding<Bool> = .constant(false)
//
//
//}
//
//extension EnvironmentValues {
//    var rootPresentation : Binding<Bool> {
//        get {
//            self[RootPresentationKey.self]
//        }
//        set {
//            self[RootPresentationKey.self] = newValue
//        }
//    }
//}


struct NavigationUtil {
    static func popToRootView() {
        findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?
            .popToRootViewController(animated: true)
    }
static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }
return nil
    }
}
