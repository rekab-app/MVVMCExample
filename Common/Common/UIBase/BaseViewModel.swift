//
//  BaseViewModel.swift
//  Common
//
//  Created by Mehdi Sohrabi on 12/8/18.
//  Copyright © 2018 sixthsolution. All rights reserved.
//

import RxSwift
import RxCocoa

public protocol BaseViewModel {
    var poppedFromNavigationStack: AnyObserver<Void?> { set get }
    var didPoppedFromNavigationStack: Observable<Void?> { set get }
    
    func getAssociatedObject(_ key: UnsafeRawPointer!, defaultValue: AnyObserver<Void?>) -> AnyObserver<Void?>
    func getAssociatedObject(_ key: UnsafeRawPointer!, defaultValue: Observable<Void?>) -> Observable<Void?>
}

public extension BaseViewModel {
    func getAssociatedObject(_ key: UnsafeRawPointer!, defaultValue: AnyObserver<Void?>) -> AnyObserver<Void?> {
        guard let value = objc_getAssociatedObject(self, key) as? AnyObserver<Void?> else {
            return defaultValue
        }
        return value
    }
    
    func getAssociatedObject(_ key: UnsafeRawPointer!, defaultValue: Observable<Void?>) -> Observable<Void?> {
        guard let value = objc_getAssociatedObject(self, key) as? Observable<Void?> else {
            return defaultValue
        }
        return value
    }
}

private struct ModelProperties {
    private static var _poppedFromNavigationStack = PublishSubject<Void?>()
    static var poppedFromNavigationStack: AnyObserver<Void?> = ModelProperties._poppedFromNavigationStack.asObserver()
    static var didPoppedFromNavigationStack: Observable<Void?> = ModelProperties._poppedFromNavigationStack.asObservable()
}

public extension BaseViewModel {
    public var poppedFromNavigationStack: AnyObserver<Void?> {
        get {
            return getAssociatedObject(&ModelProperties.poppedFromNavigationStack,
                                       defaultValue: ModelProperties.poppedFromNavigationStack)
        }
        set {
            objc_setAssociatedObject(self,
                                     &ModelProperties.poppedFromNavigationStack,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public var didPoppedFromNavigationStack: Observable<Void?> {
        get {
            return getAssociatedObject(&ModelProperties.didPoppedFromNavigationStack,
                                       defaultValue: ModelProperties.didPoppedFromNavigationStack)
        }
        set {
            objc_setAssociatedObject(self,
                                     &ModelProperties.didPoppedFromNavigationStack,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
