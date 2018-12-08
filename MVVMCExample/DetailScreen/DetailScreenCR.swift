//
//  DetailScreenCR.swift
//  MVVMCExample
//
//  Created by Mehdi Sohrabi on 12/8/18.
//  Copyright © 2018 sixthsolution. All rights reserved.
//

import UIKit
import Common
import RxSwift
import SharedNetwork

class DetailScreenCR: BaseCoordinator<Void> {
    private let post: Post
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, post: Post) {
        self.navigationController = navigationController
        self.post = post
    }
    
    override func start() -> Observable<Void> {
        let viewController = DetailScreenVC.initFromStoryboard(name: "DetailScreenSB")
        viewController.post = post
        
        let viewModel = DetailScreenVM()
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
        
        return viewModel.didPoppedFromNavigationStack.map { _ in }.take(1)
    }
}
