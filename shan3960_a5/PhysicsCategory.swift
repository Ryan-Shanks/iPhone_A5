//
//  PhysicsCategory.swift
//  shan3960_a5
//
//  Created by user136098 on 3/8/18.
//  Copyright © 2018 wlu. All rights reserved.
//

import Foundation

    struct PhysicsCategory {
        static let None: UInt32 = 0
        static let All       : UInt32 = UInt32.max
        static let Monster   : UInt32 = 0b1       // 1
        static let Projectile: UInt32 = 0b10      // 2
        static let Ship      : UInt32 = 0b100
}
