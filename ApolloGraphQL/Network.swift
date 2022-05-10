//
//  Network.swift
//  ApolloGraphQL
//
//  Created by Gonzalo Alfonso on 10/05/2022.
//

import Foundation
import Apollo

class Network {
  static let shared = Network()

  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://apollo-fullstack-tutorial.herokuapp.com/graphql")!)
}
