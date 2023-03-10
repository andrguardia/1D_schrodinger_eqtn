//
//  ContentView.swift
//  1D_schrodinger_eqtn
//
//  Created by IIT Phys 440 on 2/24/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var xMinString: String = "0.0"
    @State var xMaxString: String = "10.0"
    @State var EMinString: String = "0.0"
    @State var EMaxString: String = "1.0"
    @State var xStepString: String = "0.1"
    @State var EStepString: String = "0.1"
    @State var m_electron:Double = 510998.95 //eV/c^2
    @State var hbar_c:Double = 0.1973269804 /// in eV*um
    @State var psi_xMax: Double = 0.0
    
    @State var eigenValueArray: [(EnergyPoint: Double, YPoint: Double)] = []

    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("1D Solution to Schrodinger Equation")
            
            HStack {
                Text("X min:")
                TextField("", text: $xMinString)
                Text("X max:")
                TextField("", text: $xMaxString)
            }
            
            HStack {
                Text("E min:")
                TextField("", text: $EMinString)
                Text("E max:")
                TextField("", text: $EMaxString)
            }
            
            HStack{
                Text("X Step:")
                TextField("", text: $xStepString)
                Text("E Step:")
                TextField("", text: $EStepString)
            }
            
            Button("Compute", action: {self.calculate()})
            
            HStack {Text("Energy Eigenvalues:")
            }
        }
        
        .padding()
    }
    
    func calculate(){
        let xMin = Double(xMinString)!
        let xMax = Double(xMaxString)!
        let EMin = Double(EMinString)!
        let EMax = Double(EMaxString)!
        let XStep = Double(xStepString)!
        let EStep = Double(EStepString)!
        
        var myPotential = Potential()
        myPotential.calculateParticleInABoxPotential(xMin: xMin, xMax: xMax, xStep: XStep)
        
        var myFunctional = Energy_Functional()
        
        var myWF = Wave_Function()
        
        var const:Double = -2.0*m_electron/pow(hbar_c, 2.0)////units in 1/(eV*um^2)
        const = const*(1e-8) /// Units in 1/(eVA^2)
        
        for E in stride(from: EMin, through: EMax, by: EStep) {
            myWF.PsiArr.removeAll()
            myWF.PsiPrimeArr.removeAll()
            myWF.PsiDoublePrimeArr.removeAll()
            
            myWF.PsiArr.append((xPoint: xMin, psiPoint: 0.0))
            myWF.PsiPrimeArr.append((xPoint: xMin, psiPrimePoint: 1.0))
            myWF.PsiDoublePrimeArr.append((xPoint:xMin, psiDoublePrimePoint: 0.0))
            
            for n in 1..<myPotential.PotArr.count{
                let psiDoublePrime_n = const*myWF.PsiArr[n-1].psiPoint*(E-myPotential.PotArr[n-1].PotentialPoint)
                
                let psiPrime_n = myWF.PsiPrimeArr[n-1].psiPrimePoint + myWF.PsiDoublePrimeArr[n-1].psiDoublePrimePoint*XStep
                
                let psi_n = myWF.PsiArr[n-1].psiPoint + myWF.PsiPrimeArr[n-1].psiPrimePoint*XStep
                
                let x = myPotential.PotArr[n-1].xPoint + XStep
                
                myWF.PsiArr.append((xPoint: x, psiPoint: psi_n))
                myWF.PsiPrimeArr.append((xPoint: x, psiPrimePoint: psiPrime_n))
                myWF.PsiDoublePrimeArr.append((xPoint:x, psiDoublePrimePoint: psiDoublePrime_n))
                
            }
            let currentFunctional = myWF.PsiArr[myWF.PsiArr.count-1].psiPoint - psi_xMax
            myFunctional.EFunctionalArr.append((EnergyPoint: E, YPoint: currentFunctional))
        }
        
        
        print(myFunctional.EFunctionalArr)
        
        
        func sign(_ number: Double) -> Double {
            ///This function returns the sign of a double data type when inputted
            if number == 0 {
                return 0
            } else if number > 0 {
                return 1
            } else {
                return -1
            }
        }
        
        var previousSign: Double?
        
        for i in 1..<myFunctional.EFunctionalArr.count{
            ///This for loop parses through the elements of the Energy functional Array and finds the elements that change sign, while also printing the index of the alue hat changes sign
            
            let signCurrent = sign(myFunctional.EFunctionalArr[i].YPoint)
            
                if let prevSign = previousSign {
                    if signCurrent != prevSign {
                        print("EigenValue Found!")
                        print(i)
                        eigenValueArray.append(myFunctional.EFunctionalArr[i])
                    }
                }
                previousSign = signCurrent
        }
        
        print(eigenValueArray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
