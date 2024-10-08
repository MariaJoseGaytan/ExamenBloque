//
//  CharactersListView.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 07/10/24.
//

import SwiftUI

struct CharactersListView: View {
    @StateObject private var viewModel = CharacterViewModel()
    let availableGenders: [String] = ["Male", "Female"]
    
    var body: some View {
        NavigationView {
            VStack {
                // Barra de Búsqueda
                SearchBar(text: $viewModel.searchText)
                    .padding(.horizontal)
                    .padding(.top)
                
                // Filtros de Género
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        // Filtro por Género
                        FilterSection(
                            title: "Género",
                            options: availableGenders,
                            selectedOptions: $viewModel.selectedGenders,
                            toggleOption: viewModel.toggleGender
                        )
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 5)
                
                Divider()
                
                // Verificación de la lista de personajes
                if viewModel.characters.isEmpty && !viewModel.isLoading {
                    Spacer()
                    Text("No se encontraron personajes con esos filtros.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                } else {
                    // Lista de Personajes
                    List {
                        ForEach(viewModel.characters) { character in
                            NavigationLink(destination: CharacterDetailView(character: character)) {
                                HStack {
                                    AsyncImage(url: URL(string: character.image)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
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
                                        Text(character.gender)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.vertical, 8)
                            }
                            .onAppear {
                                viewModel.loadMoreIfNeeded(currentItem: character)
                            }
                        }
                        
                        if viewModel.isLoading {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Dragon Ball Characters")
            .onAppear {
                viewModel.fetchCharacters(reset: true)
            }
            .alert(isPresented: Binding<Bool>(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? "Error desconocido"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
