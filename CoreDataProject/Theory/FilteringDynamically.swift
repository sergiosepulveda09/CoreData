//
//  FilteringDynamically.swift
//  CoreDataProject
//
//  Created by Sergio Sepulveda on 2021-07-28.
//

import SwiftUI
import CoreData

struct FilteringDynamically: View {
    
    @Environment(\.managedObjectContext) var mocExample
    @State private var lastNameFilter: String = ""
    private var sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor(keyPath: \Singer.firstName, ascending: true), NSSortDescriptor(keyPath: \Singer.lastName, ascending: true)]
    @State private var filterKey: String = "firstName"
    @State private var filterType: String = "BEGINSWITH"
    private var filterKeys: [String] = ["firstName", "lastName"]
    private enum filterValuesEnum: String, CaseIterable, Identifiable {
        var id: String {
            self.rawValue
        }
        case equalTo = "=="
        case lessThan = "<"
        case biggerThan = ">"
        case beginsWithNoCaseSen = "BEGINSWITH[c]"
        case beginsWithCaseSen = "BEGINSWITH"
    }
    
    var body: some View {
        NavigationView {
            
            Form {
                
                FilteredList(filterKey: filterKey, filterType: filterType, filterValue: lastNameFilter, sortDescriptors: sortDescriptors) { (singer: Singer) in
                    Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
                }
                
                
                Section {
                    Button("Add Examples") {
                        let taylor = Singer(context: self.mocExample)
                        taylor.firstName = "Taylor"
                        taylor.lastName = "Swift"
                        let ed = Singer(context: self.mocExample)
                        ed.firstName = "Ed"
                        ed.lastName = "Sheeran"
                        let adele = Singer(context: self.mocExample)
                        adele.firstName = "Adele"
                        adele.lastName = "Adkins"
                        
                        do {
                            try self.mocExample.save()
                        } catch {
                            print("Error saving examples: \(error.localizedDescription)")
                        }
                        
                    }
//                    Button("Show A") {
//                        self.lastNameFilter = "A"
//                    }
//                    
//                    Button("Show S") {
//                        self.lastNameFilter = "S"
//                    }
                    Picker("Show ", selection: $lastNameFilter) {
                        Text("A").tag("A")
                        Text("S").tag("S")
                    }
                    Picker("Filter Criteria", selection: $filterKey) {
                        ForEach(filterKeys, id: \.self) { filterCriteria in
                            Text(filterCriteria)
                        }
                    }
                    Picker("FilterType", selection: $filterType) {
                        ForEach(filterValuesEnum.allCases) { cases in
                            Text("\(cases.rawValue)")
                        }
                    }
                }
                
                
            }
        }
    }
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> {
        fetchRequest.wrappedValue
    }
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
        
    }
    
    init(filterKey: String, filterType: String, filterValue: String, sortDescriptors: [NSSortDescriptor],  @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "\(filterKey) \(filterType) %@", filterValue))
        self.content = content
        
    }
}

struct FilteringDynamically_Previews: PreviewProvider {
    static var previews: some View {
        FilteringDynamically()
    }
}
