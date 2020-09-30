//
//  TableRowModel.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 30.09.20.
//

import AutoGraphQL
import Foundation


class TableRowModel<Root>: Identifiable, ObservableObject {

    let keyPath: PartialKeyPath<Root>
    let name: String

    var children: [TableRowModel<Root>]? = nil
    var state: TableRowModelState = .deselected


    var graphQLSelectionSet: AutoGraphQL.SelectionType? {
        guard isSelected else {
            return nil
        }

        guard let children = children else {
            return Scalar(name: name)
        }

        return Object(name: name, selectionSet: children.compactMap(\.graphQLSelectionSet))
    }

    var isSelected: Bool {
        children?.contains { $0.isSelected }
            ??
        (state == .selected)
    }

    var isLoaded: Bool {
        if let children = children {
            return children.contains {
                if case .loaded = $0.state {
                    return true
                }
                else {
                    return false
                }
            }
        }
        else if case .loaded = state {
            return true
        }
        else {
            return false
        }
    }


    func resetToDeselected() {
        state = .deselected

        children?.forEach {
            $0.resetToDeselected()
        }
    }

    func update(result: Any) {
        if let children = children {
            let properties: [ResponseProperty] = Mirror(reflecting: result).children.compactMap {
                guard let label = $0.label,
                      let value = Mirror(reflecting: $0.value).descendant("some") else {
                    return nil
                }

                return ResponseProperty(name: label, value: value)
            }

            // Update children
            for child in children {
                guard let property = properties.first(where: { $0.name == child.name }) else {
                    continue
                }

                child.update(result: property.value)
            }
        }
        else {
            state = .loaded("\(result)")
        }
    }


    init(keyPath: PartialKeyPath<Root>,
         name: String,
         children: [TableRowModel<Root>]? = nil,
         state: TableRowModelState = .deselected) {

        self.keyPath = keyPath
        self.name = name
        self.children = children
        self.state = state
    }


    // MARK: Identifiable

    let id = UUID()
}
