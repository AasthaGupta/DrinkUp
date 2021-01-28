//
//  ContentView.swift
//  Drink up
//
//  Created by Gupta, Aastha on 8/16/20.
//  Copyright © 2020 Gupta, Aastha. All rights reserved.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @EnvironmentObject var userStore: UserStore

    @ObservedObject var todayData: WaterTracker = DataManager.shared.getData()
    var body: some View {
        NavigationView {
            VStack {
                Text("Goal: \(userStore.currentUserInfo?.userGoal ?? "")")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text("Today's progress: \(todayData.progress)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Button(action: {
                    DataManager.shared.save()
                }) {
                    Text("Add")
                }
            }
            .navigationBarTitle(Text("Drink Up"), displayMode: .inline)
            .navigationBarItems(leading: NavigationLink(destination: UserView()) {
                HStack {
                    userStore.currentUserInfo.map { Text($0.userName) }
                    Image(systemName: "person.fill")
                }
                }
            )
                .onAppear {
                    if let userInfoData: Data = UserDefaults.standard.object(forKey: "UserInfo") as? Data, let storedUserInfo: UserInfo = try? JSONDecoder().decode(UserInfo.self, from: userInfoData) {
                        self.userStore.currentUserInfo = storedUserInfo
                    } else {
                        self.userStore.currentUserInfo = UserInfo(userName: "", userGoal: "6")
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
