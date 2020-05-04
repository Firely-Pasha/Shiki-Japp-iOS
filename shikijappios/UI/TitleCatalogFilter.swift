//
//  TitleCatalogFilter.swift
//  shikijappios
//
//  Created by Pavel on 04.05.2020.
//  Copyright © 2020 Pagala Co. All rights reserved.
//

import SwiftUI

struct TitleCatalogFilter: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Status")) {
                    CheckboxView(title: "Anons")
                    CheckboxView(title: "Ongoing")
                    CheckboxView(title: "Release")
                }
                Section(header: Text("Type")) {
                    CheckboxView(title: "TV Series")
                    CheckboxView(title: "Film")
                    CheckboxView(title: "Ova")
                    CheckboxView(title: "Ona")
                    CheckboxView(title: "Special")
                    CheckboxView(title: "Music")
                }
                Section(header: Text("Rating")) {
                    CheckboxView(title: "G")
                    CheckboxView(title: "PG")
                    CheckboxView(title: "PG-13")
                    CheckboxView(title: "R-17")
                    CheckboxView(title: "R+")
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .navigationBarTitle("Filters")
            .navigationBarItems(trailing: HStack {
                Button(action: {
                    
                }) {
                    Image("apply")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .foregroundColor(Color.purple)
            })
        }
    }
}

struct TitleCatalogFliterCheckBox: View {
    var title: String
    var value: TitleStatus
    @State var isOn = false
    
    var body: some View {
        Toggle(isOn: $isOn) {
            HStack {
                Image("menu")
                    .resizable()
                    .frame(width: 30, height: 30)

                Text("LOL")
            }
        }
    }
}

struct CheckboxView : View {

    var title: String
    @State var checkState: Int = 0;

    var body: some View {

        Button(action: {
            self.checkState = (self.checkState + 1) % 3
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(self.checkState == 0 ? "checkboxEmpty" : (self.checkState == 1 ? "checkboxAdd" : "checkboxRemove"))
                    .resizable()
                    .foregroundColor(self.checkState == 0 ? Color.black : (self.checkState == 1 ? Color.green : Color.red))
                    .frame(width: 30, height: 30, alignment: .center)
                
                Text(self.title)
                    .foregroundColor(.primary)
            }
        }

    }

}
struct TitleCatalogFilter_Previews: PreviewProvider {
    static var previews: some View {
        TitleCatalogFilter()
    }
}
