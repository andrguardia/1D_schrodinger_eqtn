//
//  Potential.swift
//  1D_schrodinger_eqtn
//
//  Created by IIT Phys 440 on 2/24/23.
//

import SwiftUI

class Potential: NSObject {
    
    
    var PotArr = [(xPoint: Double, PotentialPoint: Double)]()
   
    func calculateParticleInABoxPotential(xMin: Double, xMax:Double, xStep: Double){
        ///This class creates a potential for the one dimensional particle in the box problem. Takes in xmin, xmax and an xstep parameter
        
        PotArr.append((xPoint: xMin, PotentialPoint: 1e6))
        
        for x in stride(from: xMin+xStep, to: xMax, by: xStep) {
            PotArr.append((xPoint: x, PotentialPoint: 0.0))
        }
        
        PotArr.append((xPoint: xMax, PotentialPoint: 1e6))
    }

}
