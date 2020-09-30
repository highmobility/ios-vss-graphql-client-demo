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
                .font(Font.system(.body, design: .monospaced).lowercaseSmallCaps())

            Spacer()

            if row.children == nil {
                Group {
                    switch row.state {
                    case .selected:
                        Image(systemName: "checkmark.circle")

                    case .loading:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .genivi))

                    case .loaded(let value):
                        Text(value)

                    default:
                        Image(systemName: "circle")
                    }
                }
                .foregroundColor(.genivi)
                .padding(.trailing, 3)
            }
        }
        .onTapGesture {
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


struct TableRow_Previews: PreviewProvider {

    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
            .environmentObject(AppContext())
    }
}
