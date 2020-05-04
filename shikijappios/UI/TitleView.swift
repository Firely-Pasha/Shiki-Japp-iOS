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
                if (self.anime != nil) {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 20) {
                                TitleMainInfoView(padding: geometry.safeAreaInsets.top, anime: self.anime!)
                                TitleViewScoreView(anime: self.anime!)
                                TitleDecription(anime: self.anime!)
                            }
                            .padding(.bottom, geometry.safeAreaInsets.bottom + 5)
                        }
                        .frame(alignment: Alignment.leading)
                        .clipShape(Rectangle())
                }
            }
        }
        .navigationBarTitle(Text(self.title.prefix(25)))
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            self.api.getAnime(animeId: self.animeId) { anime in
                self.anime = anime
            }
        }
    }
}

struct TitleMainInfoView : View {
    var padding: CGFloat
    var anime: AnimeInfo
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
            ZStack(alignment: Alignment.leading) {
                KFImage(URL(string: ShikimoriApi.getImageUrl(path: self.anime.image.original)))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 395, height: 550)
                    .clipShape(Rectangle())
                    .edgesIgnoringSafeArea(.all)
                
                VisualEffectView(effect: UIBlurEffect(style: colorScheme == .dark ? .dark : .light))
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    VStack {
                        Text(self.anime.name)
                            .fontWeight(Font.Weight.bold)
                            .foregroundColor(colorScheme == .dark ? Color.gray : Color.init(white: 0.3))
                            .font(.system(size: 20))
                    }
                    HStack(alignment: .top, spacing: 20) {
                        KFImage(URL(string: ShikimoriApi.getImageUrl(path: self.anime.image.original)))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 170, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text(self.anime.kind.getString())
                                    .font(.system(size: 20))
                                    .bold()
                                if self.anime.duration != nil && self.anime.duration != 0 {
                                    Text("\(self.anime.duration!) min.")
                                        .font(.system(size: 20))
                                }
                            }
                            if self.anime.status != nil {
                                Group {
                                    Text("\(self.anime.status.getString())")
                                        .font(.system(size: 20))
                                        .padding(5)
                                }
                                .background(self.anime.status == .released ? Color.green : (self.anime.status == .anons ? Color.red : Color.blue))
                                .clipShape(RoundedRectangle.init(cornerRadius: 10))
                            }
                            VStack(alignment: .leading) {
                                if self.anime.aired_on != nil {
                                    Text((self.anime.kind == .tv ? "Since: " : "") + self.anime.aired_on!)
                                        .font(.system(size: 20))
                                }
                                if self.anime.released_on != nil {
                                    Text("To: " + self.anime.released_on!)
                                        .font(.system(size: 20))
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.top, padding)
                .padding(.horizontal, 25)
            
        }
    }
}

struct TitleViewScoreView: View {
    var anime: AnimeInfo
    
    var body: some View {
        VStack {
            if (anime.status != TitleStatus.anons) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Score")
                        .font(.title)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Users: \(anime.score)")
                                .font(.body)
                        }
                    }
                }
                .padding(.horizontal, 25)
            }
        }
    }
}

struct TitleDecription: View {
    var anime: AnimeInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Description")
                .font(.title)

            Text(anime.description ?? "There is no descrition")
                .font(.body)
        }
        .padding(.horizontal, 25)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(animeId: 1, title: "Cowboy Bebop", anime: nil)
    }
}
