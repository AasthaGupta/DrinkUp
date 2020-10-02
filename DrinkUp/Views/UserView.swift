//
//  UserView.swift
//  Drink up
//
//  Created by Gupta, Aastha on 10/2/20.
//  Copyright © 2020 Gupta, Aastha. All rights reserved.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var userStore: UserStore
    @Environment(\.presentationMode) var presentationMode

    @State var userName: String = ""
    @State var userGoal: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User")) {
                    TextField("User Name", text: $userName)
                }
                Section(header: Text("Goal")) {
                    TextField("Number of glasses", text: $userGoal).keyboardType(.numberPad)
                }
            }
        }
        .navigationBarTitle(Text("\(userName) Info"), displayMode: .inline)
        .navigationBarItems(
            trailing:
            Button(action: updateUserInfo) {
                Text("Update")
            }
        )
        .onAppear {
            self.userName = self.userStore.currentUserInfo?.userName ?? ""
            self.userGoal = self.userStore.currentUserInfo?.userGoal ?? ""
        }

    }

    func updateUserInfo() {
        let newUserInfo = UserInfo(userName: userName, userGoal: userGoal)
        userStore.currentUserInfo = newUserInfo
        presentationMode.wrappedValue.dismiss()
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(userName: "Aastha", userGoal: "8")
    }
}
