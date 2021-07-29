//
//  OneToManyRelationship.swift
//  CoreDataProject
//
//  Created by Sergio Sepulveda on 2021-07-28.
//

import SwiftUI

struct OneToManyRelationship: View {
    
    @Environment(\.managedObjectContext) var mocExample
    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
    
    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(header: Text(country.wrappedFullName)) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            
            Button("Add") {
                let candy1 = Candy(context: self.mocExample)
                candy1.name = "Mars"
                candy1.origin = Country(context: self.mocExample)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"
                let candy2 = Candy(context: self.mocExample)
                candy2.name = "KitKat"
                candy2.origin = Country(context: self.mocExample)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"
                let candy3 = Candy(context: self.mocExample)
                candy3.name = "Twix"
                candy3.origin = Country(context: self.mocExample)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"
                let candy4 = Candy(context: self.mocExample)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: self.mocExample)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"
                
                try? self.mocExample.save()
                
                
            }
        }
    }
}

struct OneToManyRelationship_Previews: PreviewProvider {
    static var previews: some View {
        OneToManyRelationship()
    }
}
