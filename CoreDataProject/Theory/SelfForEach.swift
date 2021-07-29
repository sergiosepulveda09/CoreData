//
//  SelfForEach.swift
//  CoreDataProject
//
//  Created by Sergio Sepulveda on 2021-07-28.
//

import SwiftUI

struct StudentExample: Hashable {
    let name: String
}

struct SelfForEach: View {
    
    let examples: [StudentExample] = [StudentExample(name: "Harry Potter"), StudentExample(name: "Sergio Sepulveda")]
    
    var body: some View {
        List {
            ForEach(examples, id: \.self) { exampleStudent in
                Text(exampleStudent.name)
            }
        }
    }
}

struct SelfForEach_Previews: PreviewProvider {
    static var previews: some View {
        SelfForEach()
    }
}
