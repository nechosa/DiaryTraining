//
//  TrainingScreen.swift
//  DiaryTraining
//
//  Created by Ilya Nechoysa on 26.07.2021.
//

import SwiftUI

private enum Constants {
    static let title = "Тренировочный план"
    static let buttonTitle = "Показать тренировочный план"
}

private enum Error {
    static let title: String = "Ошибка"
    static let message: String = "К сожалению данная опция недоступна!"
    static let buttonOk = "Ошибка"
}

struct TrainingScreen: View {

    @State private var showPopUp: Bool = false

    init() {
        UINavigationBar.appearance().barTintColor = UIColor(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1))
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
    }


    var body: some View {
        ZStack {
            NavigationView {
                ZStack(alignment: .center) {
                    Color(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)).ignoresSafeArea()
                    Button(action: {
                        withAnimation(.linear(duration: 0.3)) {
                            showPopUp.toggle()
                        }
                    }, label: {
                        Text(Constants.buttonTitle)
                    })
                    .padding()
                    .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Constants.title)
                .foregroundColor(Color.white)
            }

            PopupView(title: Error.title, message: Error.message, buttonText: Error.buttonOk, show: $showPopUp)
        }
    }
}

struct TrainingScreen_Previews: PreviewProvider {
    static var previews: some View {
        TrainingScreen()
    }
}

