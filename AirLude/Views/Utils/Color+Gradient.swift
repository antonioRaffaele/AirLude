//
//  Color+Gradient.swift
//  AirLude
//
//  Created by Valerio Mosca on 15/12/22.
//

import SwiftUI

extension Color {
    
    static var blueGradient: LinearGradient {
        LinearGradient(
            gradient: .init(colors: [Color.cyan, Color.blue.opacity(0.75)]),
            startPoint: .init(x: -0.33, y: -0.33),
            endPoint: .init(x: 0.66, y: 0.66)
        )
    }
    
    static var orangeGradient: LinearGradient {
        LinearGradient(
            gradient: .init(colors: [Color.orange, Color.red.opacity(0.75)]),
            startPoint: .init(x: -0.33, y: -0.33),
            endPoint: .init(x: 0.66, y: 0.66)
        )
    }
    
    static var purpleGradient: LinearGradient {
        LinearGradient(
            gradient: .init(colors: [Color.indigo, Color.purple.opacity(0.75)]),
            startPoint: .init(x: -0.33, y: -0.33),
            endPoint: .init(x: 0.66, y: 0.66)
        )
    }
    
    static var greenGradient: LinearGradient {
        LinearGradient(
            gradient: .init(colors: [Color.yellow, Color.green.opacity(0.75)]),
            startPoint: .init(x: -0.33, y: -0.33),
            endPoint: .init(x: 0.66, y: 0.66)
        )
    }
    
    static var blackGradient: LinearGradient {
        LinearGradient(
            gradient: .init(colors: [Color.white, Color.black.opacity(0.75)]),
            startPoint: .init(x: -0.33, y: -0.33),
            endPoint: .init(x: 0.66, y: 0.66)
        )
    }
    
}
