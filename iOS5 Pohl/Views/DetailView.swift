//
//  DetailView.swift
//  iOS5 Pohl
//
//  Created by Marlin Pohl on 12.12.23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State var person: Person
    
    var body: some View {
        VStack{
            TextField("Please enter a name", text: $person.name).padding()
            Spacer()
        }
        .navigationTitle(person.name)
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}
