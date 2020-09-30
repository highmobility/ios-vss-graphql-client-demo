//
//  GraphQLRequest.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 30.09.20.
//

import Alamofire
import AutoGraphQL
import Foundation
import JSONValueRX


class GraphQLRequest<Type>: AutoGraphQL.Request where Type: GraphQLType {

    init(operation: AutoGraphQL.Operation) {
        queryDocument = operation
    }


    // MARK: Request

    let queryDocument: AutoGraphQL.Operation
    let rootKeyPath: String = Type.rootKeyPath
    let variables: [AnyHashable : Any]? = nil

    func willSend() throws { }
    func didFinishRequest(response: HTTPURLResponse?, json: JSONValue) throws { }
    func didFinish(result: AutoGraphResult<Type>) throws { }
}
