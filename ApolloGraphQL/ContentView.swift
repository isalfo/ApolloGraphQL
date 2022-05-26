//
//  ContentView.swift
//  ApolloGraphQL
//
//  Created by Gonzalo Alfonso on 10/05/2022.
//

import SwiftUI

struct ContentView: View {
  @State var testText: String = ""
  @State private var launches = [LaunchListQuery.Data.Launch.Launch]()
  @State private var showAlert: Bool = false
  @State private var errorMessage: String = ""
  
  enum ListSection: Int, CaseIterable {
    case launches
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(launches, id: \.id) { launch in
          VStack {
            Text(launch.site ?? "")
          }
        }
      }
    }
    .alert(isPresented: $showAlert, content: {
      Alert(title: Text("GraphQL Error"), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
    })
    .onAppear {
      Network.shared.apollo.fetch(query: LaunchListQuery()) { result in
        switch result {
        case .success(let graphQLResult):
          if let launchConnection = graphQLResult.data?.launches {
            self.launches.append(contentsOf: launchConnection.launches.compactMap { $0 })
            if let errors = graphQLResult.errors {
              let message = errors
                    .map { $0.localizedDescription }
                    .joined(separator: "\n")
              errorMessage = message
              showAlert = true
              
            }
          }
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
