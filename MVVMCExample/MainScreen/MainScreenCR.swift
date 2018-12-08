//
//  MainScreenCR.swift
//  MVVMCExample
//
//  Created by Mehdi Sohrabi on 12/8/18.
//  Copyright © 2018 sixthsolution. All rights reserved.
//

import UIKit
import Common
import RxSwift
import SharedNetwork

class MainScreenCR: BaseCoordinator<Void> {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let viewController = MainScreenVC.initFromStoryboard(name: "MainScreenSB")
        
        let viewModel = MainScreenVM(apiClient: ApiClient())
        viewController.viewModel = viewModel
        viewModel.bindViewDidLoad(viewController.rx.viewDidLoad.asDriver())
        
        let itemDetail = viewModel.didItemClicked
            .flatMap { [unowned self] post -> Observable<Void> in
                return self.showDetailPage(navigationController: self.navigationController, post: post)
        }
        
        self.navigationController.pushViewController(viewController, animated: true)
        
        return itemDetail
    }
}

extension MainScreenCR {
    func showDetailPage(navigationController: UINavigationController, post: Post) -> Observable<Void> {
        let cr = DetailScreenCR(navigationController: navigationController, post: post)
        return coordinate(to: cr)
    }
}
