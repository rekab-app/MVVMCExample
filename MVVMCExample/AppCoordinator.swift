//
//  AppCoordinator.swift
//  MVVMCExample
//
//  Created by Mehdi Sohrabi on 12/8/18.
//  Copyright © 2018 sixthsolution. All rights reserved.
//

import UIKit
import Common
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow
    private let rootNavigation: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        rootNavigation = UINavigationController()
    }
    
    override func start() -> Observable<Void> {
        self.window.rootViewController = rootNavigation
        self.window.makeKeyAndVisible()
        
        let cr = MainScreenCR(navigationController: rootNavigation)
        return coordinate(to: cr)
    }
}
