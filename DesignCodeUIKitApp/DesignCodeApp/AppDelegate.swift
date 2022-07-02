//
//  AppDelegate.swift
//  DesignCodeApp
//
//  Created by Meng To on 11/14/17.
//  Copyright © 2017 Meng To. All rights reserved.
//

import UIKit
import Ambience

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let ambience = Ambience.shared

        ambience.insert([
            .invert(upper: 0.2),
            .regular(lower: 0.1, upper: 1.0),
            .contrast(lower: nil),
        ])

        RealmManager.loadFromData()

        return true
    }
}
