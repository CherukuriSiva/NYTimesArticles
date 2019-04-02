//
//  UIStoryboard.swift
//  XebiaAssignment
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import UIKit

extension UIStoryboard {
    class func viewController(screenName: String, storyboardName: String, bundle: Bundle? = nil) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: screenName)
    }
}
