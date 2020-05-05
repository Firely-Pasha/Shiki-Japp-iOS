//
//  TitleCatalogFilter.swift
//  shikijappios
//
//  Created by Pavel on 04.05.2020.
//  Copyright © 2020 Pagala Co. All rights reserved.
//

import SwiftUI
import ActivityIndicatorView

struct TitleCatalogFilter: View {
    
    @Binding var isFilterVisible: Bool
    @State var isIndicatorVisible = true
    
    @ObservedObject var titleStatus: CollectionParameter<TitleStatus>
    @ObservedObject var animeKind: CollectionParameter<AnimeKind>
    @ObservedObject var animeRating: CollectionParameter<AnimeRating>
    
    var onApplyFilter: () -> ()
    
    var body: some View {
        NavigationView {
            VStack {
                if (isIndicatorVisible) {
                    ActivityIndicatorView(isVisible: $isIndicatorVisible, type: .default)
                        .frame(width: 25.0, height: 25.0, alignment: .center)
                        .foregroundColor(Color.purple)
                } else {
                    Form {
                        Section(header: Text("Status")) {
                            CheckboxView<TitleStatus>(title: "Anons", parameters: titleStatus, value: .anons)
                            CheckboxView<TitleStatus>(title: "Ongoing", parameters: titleStatus, value: .ongoing)
                            CheckboxView<TitleStatus>(title: "Release", parameters: titleStatus, value: .released)
                        }
                        Section(header: Text("Type")) {
                            CheckboxView(title: "TV Series", parameters: animeKind, value: .tv)
                            CheckboxView(title: "Film", parameters: animeKind, value: .movie)
                            CheckboxView(title: "Ova", parameters: animeKind, value: .ova)
                            CheckboxView(title: "Ona", parameters: animeKind, value: .ona)
                            CheckboxView(title: "Special", parameters: animeKind, value: .special)
                            CheckboxView(title: "Music", parameters: animeKind, value: .music)
                        }
                        Section(header: Text("Rating")) {
                            CheckboxView(title: "G", parameters: animeRating, value: .g)
                            CheckboxView(title: "PG", parameters: animeRating, value: .pg)
                            CheckboxView(title: "PG-13", parameters: animeRating, value: .pg_13)
                            CheckboxView(title: "R", parameters: animeRating, value: .r)
                            CheckboxView(title: "R+", parameters: animeRating, value: .r_plus)
                        }
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .navigationBarTitle("Filters")
            .navigationBarItems(
                leading: HStack {
                    Button(action: {
                        self.titleStatus.clear()
                        self.animeKind.clear()
                    }) {
                        Image("clearFilter")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    .foregroundColor(Color.purple)
                },
                trailing: HStack {
                    Button(action: {
                        self.onApplyFilter()
                        self.isFilterVisible = false
                    }) {
                        Image("apply")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    .foregroundColor(Color.purple)
                }
            )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.isIndicatorVisible = false
                }
            }
        }
    }
}

struct CheckboxView<T: Hashable> : View {
    
    var title: String
    @ObservedObject var parameters: CollectionParameter<T>
    var value: T
    
    var body: some View {
        
        Button(action: {
            let checkState = (self.getState() + 1) % 3
            if (checkState == 0) {
                self.parameters.remove(item: self.value)
            } else if (checkState == 1) {
                self.parameters.addInclude(item: self.value)
            } else if (checkState == 2) {
                self.parameters.addExclude(item: self.value)
            }
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(self.getState() == 0 ? "checkboxEmpty" : (self.getState() == 1 ? "checkboxAdd" : "checkboxRemove"))
                    .resizable()
                    .foregroundColor(self.getState() == 0 ? Color.black : (self.getState() == 1 ? Color.green : Color.red))
                    .frame(width: 25, height: 25, alignment: .center)
                
                Text(self.title)
                    .foregroundColor(.primary)
            }
        }
        .onAppear {
        }
        
    }
    
    private func getState() -> Int {
        if (self.parameters.containsInclude(item: self.value)) {
            return 1
        } else if (self.parameters.containsExclude(item: self.value)) {
            return 2
        } else {
            return 0
        }
    }
    
}
//struct TitleCatalogFilter_Previews: PreviewProvider {
//    static var previews: some View {
////        TitleCatalogFilter(isFilterVisible: Binding(false))
//    }
//}
