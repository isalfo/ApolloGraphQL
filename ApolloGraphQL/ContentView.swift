//
//  ContentView.swift
//  ApolloGraphQL
//
//  Created by Gonzalo Alfonso on 10/05/2022.
//

import SwiftUI

struct ContentView: View {
  @State var testText: String = ""
    var body: some View {
      NavigationView {
          Text(testText)
      }
      .onAppear {
        Network.shared.apollo.fetch(query: LaunchListQuery()) { result in
          switch result {
          case .success(let graphQLResult):
            testText = "Success! Result: \(graphQLResult)"
          case .failure(let error):
            testText = "Failure! Error: \(error)"
          }
        }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
