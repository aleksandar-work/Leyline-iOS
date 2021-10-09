//
//  TokenAddingInterceptor.swift
//  Leyline
//
//  Created by Alexey Ivlev on 2/4/21.
//

import Foundation
import Apollo
import FirebaseAuth

class TokenAddingInterceptor: ApolloInterceptor {
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        
        Auth.auth().currentUser?.getIDToken(completion: { (token, error) in
            if let token = token {
                request.addHeader(name: "Authorization", value: "Bearer \(token)")
            }
            
            chain.proceedAsync(request: request,
                               response: response,
                               completion: completion)
        })
    }
}
