//
//  TableRowModelState.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 30.09.20.
//

import Foundation


enum TableRowModelState: Equatable {

    case deselected
    case selected
    case loading
    case loaded(String)
}
