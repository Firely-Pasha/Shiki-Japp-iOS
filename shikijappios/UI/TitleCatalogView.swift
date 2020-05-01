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
    @State var animes: [Anime] = []
    @State var isBottomSheetOpen = false;
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                GridStack(
                    minCellWidth: 160,
                    spacing: 15,
                    numItems: animes.count
                ) { index, cellWidth in
                    TitleCatalogItemView(anime: self.animes[index])
                }
                .navigationBarTitle("Anime catalog")
                .navigationBarItems(
                    leading: HStack {
                        Button(action: {
                            self.isBottomSheetOpen = !self.isBottomSheetOpen;
                        }) {
                            Image("menu")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    },
                    trailing: HStack {
                        Button(action: {
                            
                        }) {
                            Image("TitleSearch")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                )
                GeometryReader() { geometry in
                    ZStack(alignment: .bottom) {
                        if (self.isBottomSheetOpen) {
                            Button(action: {
                                self.isBottomSheetOpen = false
                            }) {
                                Color.black
                                    .opacity(0.5)
                                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                                    .zIndex(2)
                                    .edgesIgnoringSafeArea(.top)
                            }
                        }
                        if (self.isBottomSheetOpen) {
                            ZStack {
                                Color.black
                                VStack {
                                    Button(action: {
                                        self.isBottomSheetOpen = false
                                    }) {
                                        Text("Anime")
                                    }
                                    .padding(10)
                                    Button(action: {
                                        self.isBottomSheetOpen = false
                                    }) {
                                        Text("Manga")
                                    }
                                    .padding(10)
                                    Button(action: {
                                        self.isBottomSheetOpen = false
                                    }) {
                                        Text("Ranobe")
                                    }
                                    .padding(10)
                                    
                                }
                                .padding(.bottom, geometry.safeAreaInsets.bottom)
                            }
                            .transition(.move(edge: .bottom))
                            .frame(height: 260)
                            .zIndex(3)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                    //                    .frame(height: 200, alignment: .bottom)
                    .animation(.default)
                    .zIndex(1)
            }
            
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
