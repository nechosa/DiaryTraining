//
//  FoodScreen.swift
//  DiaryTraining
//
//  Created by Ilya Nechoysa on 26.07.2021.
//

import SwiftUI
import Networking

private enum Contants {
    static var previousMonthDate: String {
        let date = Date().getLastOrCurrentMonth()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        return result
    }

    static let lang = "ru"
    static let apiKey = "a59e5f24831a4322b535578654582973"
    static let startPage = 1
    static let query  = "Food"
    static let sortedBy  = "publishedAt"
}

final class FoodListViewModel: ObservableObject {

    @Published var foodNewsList: [Article] = .init()

    private var fromDate: String {
        Contants.previousMonthDate
    }

    private var language: String {
        Contants.lang
    }

    func fetch( action: @escaping ()->Void ) {
        ArticlesAPI.everythingGet(
            q: Contants.query,
            from: fromDate,
            sortBy: Contants.sortedBy,
            language: language,
            apiKey: Contants.apiKey,
            page: Contants.startPage,
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


extension Date {

    func getLastOrCurrentMonth() -> Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: self) ?? self
    }

}
