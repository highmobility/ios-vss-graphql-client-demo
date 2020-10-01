//
//  TableRow.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 30.09.20.
//

import SwiftUI


struct TableRow<Root>: View {

    @EnvironmentObject var context: AppContext
    @State var row: TableRowModel<Root>


    var body: some View {
        HStack {
            Text(row.name)
                .font(Font.system(size: 14.0, design: .monospaced).lowercaseSmallCaps())

            Spacer()

            if row.children == nil {
                Group {
                    switch row.state {
                    case .deselected:
                        if !context.model.isLoaded {
                            Image(systemName: "circle")
                        }

                    case .selected:
                        if !context.model.isLoaded {
                            Image(systemName: "checkmark.circle")
                        }

                    case .loading:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .genivi))

                    case .loaded(let value):
                        Text(value)
                    }
                }
                .foregroundColor(.genivi)
                .padding(.trailing, 3)
            }
        }
        .onTapGesture {
            if !context.model.isLoaded {
                switch row.state {
                case .deselected:
                    row.state = .selected

                case .selected:
                    row.state = .deselected

                default:
                    break
                }

                context.objectWillChange.send()
            }
        }
    }
}


struct TableRow_Previews: PreviewProvider {

    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
            .environmentObject(AppContext())
    }
}
