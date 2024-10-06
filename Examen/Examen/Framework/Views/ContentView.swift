//
//  ContentView.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 05/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Vista1()
                .tabItem {
                    Label("Vista 1", systemImage: "1.circle")
                }

            Vista2()
                .tabItem {
                    Label("Vista 2", systemImage: "2.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
