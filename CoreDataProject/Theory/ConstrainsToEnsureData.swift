//
//  ConstrainsToEnsureData.swift
//  CoreDataProject
//
//  Created by Sergio Sepulveda on 2021-07-28.
//

import SwiftUI

struct ConstrainsToEnsureData: View {
    
    @Environment(\.managedObjectContext) var mocExample
    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unkown")
            }
            
            Button("Add") {
                let wizard = Wizard(context: self.mocExample)
                wizard.name = "Harry Potter"
            }
            
            Button("Save") {
                do {
                    try self.mocExample.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ConstrainsToEnsureData_Previews: PreviewProvider {
    static var previews: some View {
        ConstrainsToEnsureData()
    }
}
