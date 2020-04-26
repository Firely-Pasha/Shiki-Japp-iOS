//
//  TitleCatalogView.swift
//  shikijappios
//
//  Created by Pavel on 25.04.2020.
//  Copyright © 2020 Pagala Co. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
import GridStack

struct TitleCatalogView: View {
    @State var animes: [AnimeModel] = []
    
    var body: some View {
        NavigationView {
            GridStack(
                minCellWidth: 160,
                spacing: 15,
                numItems: animes.count
            ) { index, cellWidth in
                TitleCatalogItemView(anime: self.animes[index])
            }
            .navigationBarTitle("Anime catalog")
            .navigationBarItems(trailing: HStack {
                Button(action: {
                    
                }) {
                    Image("TitleSearch")
                }
            })
        }
        .onAppear {
            shikimoriApi.getAnimes(params: AnimesParams()) { (animes) in
                self.animes = animes;
            }
        }
    }
}

struct TitleCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        TitleCatalogView(animes: [])
    }
}
