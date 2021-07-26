//
//  FoodScreen.swift
//  DiaryTraining
//
//  Created by Ilya Nechoysa on 26.07.2021.
//

import SwiftUI
import Networking

final class FoodListViewModel: ObservableObject {

    @Published var foodNewsList: [Article] = .init()

    func fetch( action: @escaping ()->Void ) {
        ArticlesAPI.everythingGet(
            q: "Food",
            from: "2021-06-15",
            sortBy: "publishedAt",
            language: "ru",
            apiKey: "a59e5f24831a4322b535578654582973",
            page: 1,
            apiResponseQueue: DispatchQueue.global(qos: .utility)) { list, error in

            DispatchQueue.main.async { [weak self]  in
                self?.foodNewsList.append(contentsOf: list?.articles ?? [])
                action()
            }
        }
    }

    init() {

    }
}

extension Article: Identifiable {
    public var id: String { url }
}

struct FoodScreen: View {

    @ObservedObject var foodListViewModel = FoodListViewModel()
    @State var isAnimating: Bool = false

    var body: some View {
        ZStack {
            List(foodListViewModel.foodNewsList) { item in
                Text(item.title)
            }
            ActivityIndicator(style: .large, animate: $isAnimating).configure {
                $0.color = .red
            }
        }
        .onAppear(perform: fetch)
    }

    private func fetch() {
        isAnimating = true
        foodListViewModel.fetch {
            isAnimating = false
        }
    }
}

struct DashBoardScreen_Previews: PreviewProvider {
    static var previews: some View {
        FoodScreen()
    }
}

