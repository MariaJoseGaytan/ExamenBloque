//
//  FilterSection.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 07/10/24.
//

import SwiftUI

struct FilterSection: View {
    let title: String
    let options: [String]
    @Binding var selectedOptions: Set<String>
    let toggleOption: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            toggleOption(option)
                        }) {
                            Text(option)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(selectedOptions.contains(option) ? Color.blue : Color.gray.opacity(0.3))
                                .foregroundColor(selectedOptions.contains(option) ? .white : .black)
                                .cornerRadius(20)
                        }
                    }
                }
            }
        }
    }
}
