//
//  Particle.swift
//  SwiftUIMotions
//
//  Created by Hari on 10/06/24.
//

import Foundation

struct Particle: Hashable {
    let x: Double
    let y: Double
    let creationDate = Date.now.timeIntervalSinceReferenceDate
    let hue: Double
}
