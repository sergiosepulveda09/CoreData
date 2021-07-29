//
//  FilteringNSPredicate.swift
//  CoreDataProject
//
//  Created by Sergio Sepulveda on 2021-07-28.
//

import SwiftUI
import CoreData

struct FilteringNSPredicate: View {
    @Environment(\.managedObjectContext) var mocExample
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name <[c] %@", "F")) var ships: FetchedResults<Ship>
    /*
     NSPredicate(format: "universe == %@", "Star Wars"))
     NSPredicate(format: "name < %@", "F"))
     NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
     NSPredicate(format: "name BEGINSWITH %@", "E"))
     NSPredicate(format: "name BEGINSWITH[c] %@", "e"))
     NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e"))
     */
    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }
            
            Button("Add Example") {
                let ship1 = Ship(context: self.mocExample)
                ship1.name = "Enterprise"
                ship1.universe = "Star trek"
                let ship2 = Ship(context: self.mocExample)
                ship2.name = "Defiant"
                ship2.universe = "Star trek"
                let ship3 = Ship(context: self.mocExample)
                ship3.name = "Milennium Falcon"
                ship3.universe = "Star wars"
                let ship4 = Ship(context: self.mocExample)
                ship4.name = "Executor"
                ship4.universe = "Star wars"
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

struct FilteringNSPredicate_Previews: PreviewProvider {
    static var previews: some View {
        FilteringNSPredicate()
    }
}
