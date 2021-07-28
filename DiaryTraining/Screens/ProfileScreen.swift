//
//  ProfileScreen.swift
//  DiaryTraining
//
//  Created by Ilya Nechoysa on 26.07.2021.
//

import SwiftUI

struct ProfileScreen: View {

    @EnvironmentObject var router: Router

    var body: some View {
        Button(action: {
            router.tabSelection = 1
        }, label: {
            Text("To Food screen")
        })
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
