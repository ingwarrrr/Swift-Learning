//
//  HeroStats.swift
//  DotaTableVC
//
//  Created by Igor on 16.03.2022.
//

import Foundation

struct HeroStats: Codable {
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let legs: Int
    let img: String
}
