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
            // Sección de Personajes
            CharactersListView()
                .tabItem {
                    Label("Personajes", systemImage: "person.3")
                }
            
            // Sección de Planetas
            PlanetsListView()
                .tabItem {
                    Label("Planetas", systemImage: "globe")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
