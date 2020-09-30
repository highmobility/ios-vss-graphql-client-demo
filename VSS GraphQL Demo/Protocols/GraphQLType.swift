//
//  GraphQLType.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 30.09.20.
//

import Foundation


protocol GraphQLType: Decodable, Equatable {

    static var rootKeyPath: String { get }
}
