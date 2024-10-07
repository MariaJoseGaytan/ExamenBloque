//
//  PlanetDetailView.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 07/10/24.
//

import SwiftUI

struct PlanetDetailView: View {
    let planet: Planet
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Imagen del Planeta
                AsyncImage(url: URL(string: planet.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                
                // Información del Planeta
                VStack(alignment: .leading, spacing: 10) {
                    Text(planet.name)
                        .font(.largeTitle)
                        .bold()
                    
                    Text(planet.description)
                        .font(.body)
                    
                    Text(planet.isDestroyed ? "Estado: Destruido" : "Estado: Activo")
                        .font(.headline)
                        .foregroundColor(planet.isDestroyed ? .red : .green)
                }
                .padding()
                
                Divider()
                    .padding(.horizontal)
                
                // Lista de Personajes
                Text("Personajes")
                    .font(.title2)
                    .bold()
                    .padding([.leading, .top])
                
                if planet.characters.isEmpty {
                    Text("No hay personajes para este planeta.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(planet.characters) { character in
                        NavigationLink(destination: CharacterDetailView(character: character)) {
                            HStack {
                                AsyncImage(url: URL(string: character.image)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(character.name)
                                        .font(.headline)
                                    Text(character.affiliation)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
                
                Spacer()
            }
        }
        .navigationTitle(planet.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
