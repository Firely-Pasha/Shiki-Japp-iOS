//
//  TitleCatalogItemView.swift
//  shikijappios
//
//  Created by Pavel on 26.04.2020.
//  Copyright © 2020 Pagala Co. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct TitleCatalogItemView: View {
    @State var anime: Anime
    
    var body: some View {
        NavigationLink(destination: TitleView(animeId: self.anime.id, title: self.anime.name)) {
            VStack {
                KFImage(URL(string: ShikimoriApi.getImageUrl(path: anime.image.original)))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 170, height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .scaledToFill()
                    .padding(10)
                Text(anime.name)
                    .lineLimit(2)
                    .font(Font.system(size: 12))
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

//struct TitleCatalogItemView_Previews: PreviewProvider {
//    static var previews: some View {
////        TitleCatalogItemView()
//    }
//}
