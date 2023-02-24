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
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("1D Solution to Schrodinger Equation")
            
            HStack {
                Text("X MIN:")
                TextField("", text: $xMinString)
                Text("X MAX:")
                TextField("", text: $xMaxString)
            }
            
            HStack {
                Text("E MIN:")
                TextField("", text: $EMinString)
                Text("E MAX:")
                TextField("", text: $EMaxString)
            }
            Button("Compute", action: {self.calculate()})
        }
        
        .padding()
    }
    
    func calculate(){
        print("Calculating...")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
