//
//  ContentView.swift
//  BookSearch
//
//  Created by Bona Deny S on 11/7/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var homeVM = HomeViewModel()
    
    var body: some View {
        NavigationView {
            HomeView(vm: homeVM)
            .navigationBarTitle("Books")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
