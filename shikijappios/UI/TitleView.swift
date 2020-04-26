//
//  TitleView.swift
//  shikijappios
//
//  Created by Pavel on 26.04.2020.
//  Copyright © 2020 Pagala Co. All rights reserved.
//

import SwiftUI
import UIKit
import KingfisherSwiftUI

struct TitleView: View {
    var animeId: Int
    var title: String
    
    @State var anime: AnimeInfoModel? = nil
    
    private let api = ShikimoriApi()
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if self.anime != nil {
                    ScrollView {
                        ZStack(alignment: Alignment.leading) {
                            KFImage(URL(string: ShikimoriApi.getImageUrl(path: self.anime!.image.original)))
                                .resizable()
                                .padding(.top, -geometry.safeAreaInsets.top)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 395, height: 550)
                                .clipShape(Rectangle())
                                .edgesIgnoringSafeArea(.all)
                            
                            VisualEffectView(effect: UIBlurEffect(style: .dark))
                                .edgesIgnoringSafeArea(.all)
                            
                            VStack(alignment: .leading) {
                                VStack {
                                    Text(self.anime!.name)
                                        .fontWeight(Font.Weight.bold)
                                        .foregroundColor(Color.gray)
                                        .font(.system(size: 20))
                                }
                                HStack {
                                    KFImage(URL(string: ShikimoriApi.getImageUrl(path: self.anime!.image.original)))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 170, height: 250)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                Spacer()
                            }
                            .padding(.top, geometry.safeAreaInsets.top + 5)
                            .padding(.horizontal, 25)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.leading)
                        }
                        .frame(height: 550)
                        .clipShape(Rectangle())
                        Spacer()
                    }
                } else {
                    
                }
            }
            .navigationBarTitle(Text(self.title.prefix(25)))
            .edgesIgnoringSafeArea(.top)
            
        }
        .onAppear {
            self.api.getAnime(animeId: self.animeId) { anime in
                self.anime = anime
            }
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(animeId: 1, title: "Cowboy Bebop", anime: AnimeInfoModel(
            id: 1,
            name: "Cowboy Bebop",
            score: "9.0",
            image: ImageModel(
                original: "/system/animes/original/10582.jpg?1578500814",
                preview: "/system/animes/original/10582.jpg?1578500814",
                x96: "/system/animes/original/10582.jpg?1578500814",
                x48: "/system/animes/original/10582.jpg?1578500814")))
    }
}
