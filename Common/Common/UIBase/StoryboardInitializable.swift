//
//  StoryboardInitializable.swift
//  Common
//
//  Created by Mehdi Sohrabi on 12/8/18.
//  Copyright © 2018 sixthsolution. All rights reserved.
//

import UIKit

public protocol StoryboardInitializable {
    static var storyboardIdentifier: String { get }
}

public extension StoryboardInitializable where Self: UIViewController {
    public static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
    
    public static func initFromStoryboard(name: String = "Main") -> Self {
        let storyboard = UIStoryboard(name: name, bundle: Bundle(for: self))
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
    
    public static func initFromStoryboard(name: String = "Main", bundleId: String) -> Self {
        let storyboard = UIStoryboard(name: name, bundle: Bundle(identifier: bundleId))
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
    
    public static func initFromStoryboard(name: String = "Main", bundleId: String, identifier: String) -> Self {
        let storyboard = UIStoryboard(name: name, bundle: Bundle(identifier: bundleId))
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
