//
//  BaseViewController.swift
//  Common
//
//  Created by Mehdi Sohrabi on 12/8/18.
//  Copyright © 2018 sixthsolution. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

open class BaseViewController<VM: BaseViewModel>: UIViewController, StoryboardInitializable {
    
    public var viewModel: VM!
    public var bag = DisposeBag()
    
    override open var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // sometimes user dismiss viewcontroller by gusture and thus the coordinator will not getting free
        // so we need another mech to freeup coordinator
        if isMovingFromParent {
            viewModel.poppedFromNavigationStack.onNext(nil)
        }
    }
    
    deinit {
        bag = DisposeBag()
    }
}
