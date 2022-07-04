//
//  CATransform3D+Perspective.swift
//  DesignCodeApp
//
//  Created by Igor on 
//

import QuartzCore

fileprivate let perspective : CGFloat = -1.0/2500

func CATransform3DMakeRotationWithPerspective(_ angle : CGFloat, _ x : CGFloat, _ y : CGFloat, _ z : CGFloat) -> CATransform3D {
    var transform = CATransform3DMakeRotation(angle, x, y, z)
    transform.m34 = perspective
    return transform
}

func CATransform3DMakeTranslationWithPerspective(_ x: CGFloat, _ y : CGFloat, _ z: CGFloat) -> CATransform3D {
    var transform = CATransform3DMakeTranslation(x, y, z)
    transform.m34 = perspective
    return transform
}
