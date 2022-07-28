//
//  PreferenceKeys.swift
//  DesignCodeiOS15
//
//  Created by Igor on 2022-07-18.
//

import SwiftUI

struct ScrollPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
