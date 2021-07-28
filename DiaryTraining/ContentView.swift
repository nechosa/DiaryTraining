//
//  ContentView.swift
//  DiaryTraining
//
//  Created by Ilya Nechoysa on 25.07.2021.
//

import SwiftUI


final class Router: ObservableObject {
    @Published var tabSelection: Int = 0

    init() {
        print("👉 init Router")
    }
}

enum Tab: Int, Equatable, CaseIterable {
    case profile = 0, food, training, settings

    var imageName : String {
        switch self {
        case .profile:
            return "person"
        case .food:
            return "leaf"
        case .training:
            return "doc.plaintext"
        case .settings:
            return "gearshape.fill"
        }
    }

    var title : String {
        switch self {
        case .profile:
            return "Profile"
        case .food:
            return "Food"
        case .training:
            return "Training"
        case .settings:
            return "Settings"
        }
    }

    var tag: Int { rawValue }

    @ViewBuilder
     func fetchView() -> some View {
        switch self {
        case .profile:
             ProfileScreen()
        case .food:
            FoodScreen()
        case .training:
             TrainingScreen()
        case .settings:
             SettingsScreen()
        }
    }

}

struct ContentView: View {

    @State private var selection = 0

   // @ObservedObject var router: Router = .init()
    @EnvironmentObject var router: Router

    var body: some View {
        TabView(selection: $router.tabSelection) {
            ForEach(Tab.allCases, id: \.tag) { tab in
                tab.fetchView().tabItem {
                    Image(systemName: tab.imageName)
                    Text(tab.title)
                }.tag(tab.tag)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
