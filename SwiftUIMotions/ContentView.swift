//
//  ContentView.swift
//  SwiftUIMotions
//
//  Created by Hari on 10/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var particleSystem = ParticleSystem()
    @State private var motionManager = MotionManager()
    
    let options: [(flipX: Bool, flipY: Bool)] = [
        (false, false),
        (false, true),
        (true, false),
        (true, true)
    ]
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                particleSystem.update(date: timelineDate)
                context.blendMode = .plusLighter
                
                particleSystem.center = UnitPoint(x: 0.5 + motionManager.roll, y: 0.5 + motionManager.pitch)
                
                for particle in particleSystem.particles {
                    var contextCopy = context
                    contextCopy.addFilter(.colorMultiply(Color(hue: particle.hue, saturation: 1, brightness: 1)))
                    contextCopy.opacity = 1 - (timelineDate - particle.creationDate)
                    
                    for option in options {
                        var xPos = particle.x * size.width
                        var yPos = particle.y * size.height
                        
                        if option.flipX {
                            xPos = size.width - xPos
                        }
                        
                        if option.flipY {
                            yPos = size.height - yPos
                        }
                        
                        contextCopy.draw(particleSystem.image, at: CGPoint(x: xPos, y: yPos))
                    }
                }
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0) 
                .onChanged{ drag in
                    particleSystem.center.x = drag.location.x / UIScreen.main.bounds.width
                    particleSystem.center.y = drag.location.y / UIScreen.main.bounds.height
                }
        )
        .ignoresSafeArea()
        .background(.black)
    }
}

#Preview {
    ContentView()
}
