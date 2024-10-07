//
//  DetallePersonajeView.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 07/10/24.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Imagen del personaje
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                }
                .frame(height: 300)
                
                // Información del personaje
                Group {
                    Text(character.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text("Raza:")
                            .fontWeight(.semibold)
                        Text(character.race)
                    }
                    
                    HStack {
                        Text("Género:")
                            .fontWeight(.semibold)
                        Text(character.gender)
                    }
                    
                    HStack {
                        Text("Afiliación:")
                            .fontWeight(.semibold)
                        Text(character.affiliation)
                    }
                    
                    HStack {
                        Text("Ki:")
                            .fontWeight(.semibold)
                        Text(character.ki)
                    }
                    
                    HStack {
                        Text("Ki Máximo:")
                            .fontWeight(.semibold)
                        Text(character.maxKi)
                    }
                    
                    if let deletedAt = character.deletedAt, !deletedAt.isEmpty {
                        HStack {
                            Text("Eliminado en:")
                                .fontWeight(.semibold)
                            Text(deletedAt)
                        }
                    }
                    
                    Text("Descripción:")
                        .fontWeight(.semibold)
                    Text(character.description)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
