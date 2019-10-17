//
//  ContentView.swift
//  mock-fetch
//
//  Created by Eric Martinez on 9/25/19.
//  Copyright © 2019 emobile. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack() {
            Text("Hello World")
                .font(.largeTitle)
            HStack {
                Text("Trying out more lines in view")
                    .font(.subheadline)
                Text("Adding a new line")
                    .font(.subheadline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
