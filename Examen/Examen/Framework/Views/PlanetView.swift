//
//  PlanetView.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 07/10/24.
//

import SwiftUI

struct PlanetsListView: View {
    @StateObject private var viewModel = PlanetViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Cargando Planetas...")
                        .padding()
                    Spacer()
                } else if viewModel.planets.isEmpty {
                    Spacer()
                    Text("No se encontraron planetas.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                } else {
                    List(viewModel.planets) { planet in
                        NavigationLink(destination: PlanetDetailView(planet: planet)) {
                            HStack {
                                AsyncImage(url: URL(string: planet.image)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(8)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 60, height: 60)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(planet.name)
                                        .font(.headline)
                                    Text(planet.isDestroyed ? "Destruido" : "Activo")
                                        .font(.subheadline)
                                        .foregroundColor(planet.isDestroyed ? .red : .green)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Planetas")
            .onAppear {
                viewModel.fetchPlanets()
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

struct PlanetsListView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetsListView()
    }
}
