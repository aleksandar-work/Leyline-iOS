//
//  Network.swift
//  Leyline
//
//  Created by Alexey Ivlev on 2/4/21.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()
    
    private(set) lazy var apollo: ApolloClient = {
        let client = URLSessionClient()
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let provider = NetworkInterceptorProvider(client: client, store: store)
//        let url = URL(string: "https://staging.api.leyline.gg/graphql")!
        let url = URL(string: "https://us-central1-leyline-web-app.cloudfunctions.net/graphql")!
        let transport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                     endpointURL: url)
        return ApolloClient(networkTransport: transport, store: store)
    }()
}
