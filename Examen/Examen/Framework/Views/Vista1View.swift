//
//  Vista1View.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 06/10/24.
//

import SwiftUI

struct Vista1: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Contenido de Vista 1")
                    .navigationTitle("Vista 1")

                NavigationLink(destination: Vista3()) {
                    Text("Ir a Vista 3")
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    Vista1()
}

