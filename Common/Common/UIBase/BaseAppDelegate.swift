//
//  BaseAppDelegate.swift
//  Common
//
//  Created by Mehdi Sohrabi on 12/8/18.
//  Copyright © 2018 sixthsolution. All rights reserved.
//

import UIKit
import RxSwift

open class BaseAppDelegate: UIResponder, UIApplicationDelegate {
    public private(set) var disposeBag = DisposeBag()
    
    public override init() {
        super.init()
    }
    
    open func applicationWillTerminate(_ application: UIApplication) {
        disposeBag = DisposeBag()
    }
}
