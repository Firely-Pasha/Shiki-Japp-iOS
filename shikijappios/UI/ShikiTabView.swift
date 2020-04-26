//
//  TabView.swift
//  shikijappios
//
//  Created by Pavel on 25.04.2020.
//  Copyright © 2020 Pagala Co. All rights reserved.
//

import SwiftUI

struct ShikiTabView: View {
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            Text("Profile")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("first")
                        Text("Profile")
                    }
            }
            .tag(0)
            TitleCatalogView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image("second")
                            .colorInvert()
                        Text("Catalog")
                    }
            }
            .tag(1)
            Text("Settings")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("second")
                        Text("Settings")
                    }
            }
            .tag(2)
        }
        
    }
}

struct ShikiTabView_Previews: PreviewProvider {
    static var previews: some View {
        ShikiTabView()
    }
}
