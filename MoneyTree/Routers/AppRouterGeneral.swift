//
//  AppRouterGeneral.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 5/4/22.
//

import Foundation

class AppRouterGeneral: AppRouter {
    override init() {
        super.init()
    }
    
    override class func sharedInstance() -> AppRouterGeneral {
        struct __ { static let _sharedInstance = AppRouterGeneral() }
        return __._sharedInstance
    }
}

extension AppRouterGeneral: GeneralRoutable {
    
    func navigateBack() {
        pop()
    }
    
    func handleError(error: Error) {
        print(error.localizedDescription)
    }
    
}

