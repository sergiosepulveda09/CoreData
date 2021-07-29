//
//  SavingDataNSMOC.swift
//  CoreDataProject
//
//  Created by Sergio Sepulveda on 2021-07-28.
//

import SwiftUI

struct SavingDataNSMOC: View {
    
    @Environment(\.managedObjectContext) var mocExample
    
    var body: some View {
        Button("Save") {
            if mocExample.hasChanges {
                do {
                    try self.mocExample.save()
                } catch {
                    print("Couldnt't save data")
                }
            }
        }
    }
}

struct SavingDataNSMOC_Previews: PreviewProvider {
    static var previews: some View {
        SavingDataNSMOC()
    }
}
