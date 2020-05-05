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
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var animes: [Anime] = []
    @State var isTitleTypeSheetOpen = false;
    @State var isFilterSheetOpen = false;
    @State private var offset = CGSize.zero
    private let modalHeight: CGFloat = 260
    
    @ObservedObject var titleStatus = CollectionParameter<TitleStatus>()
    @ObservedObject var animeKind = CollectionParameter<AnimeKind>()
    @ObservedObject var animeRating = CollectionParameter<AnimeRating>()
    
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
                .id(UUID())
                .navigationBarTitle("Anime")
                .navigationBarItems(
                    leading: HStack {
                        Button(action: {
                            self.isTitleTypeSheetOpen = !self.isTitleTypeSheetOpen
                        }) {
                            Image("menu")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                    },
                    trailing: HStack {
                        Button(action: {
                            self.isFilterSheetOpen = true
                        }) {
                            Image("filter")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                    }
                )
                GeometryReader() { geometry in
                    ZStack(alignment: .bottom) {
                        if (self.isTitleTypeSheetOpen) {
                            Button(action: {
                                self.isTitleTypeSheetOpen = false
                            }) {
                                Color.black
                                    .opacity(0.5)
                                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                                    .zIndex(2)
                                    .edgesIgnoringSafeArea(.top)
                            }
                        }
                        if (self.isTitleTypeSheetOpen) {
                            ZStack {
                                if (self.colorScheme == .dark) {
                                    Color.black
                                } else {
                                    Color.white
                                }
                                VStack {
                                    Button(action: {
                                        self.isTitleTypeSheetOpen = false
                                    }) {
                                        Text("Anime")
                                    }
                                    .padding(10)
                                    Button(action: {
                                        self.isTitleTypeSheetOpen = false
                                    }) {
                                        Text("Manga")
                                    }
                                    .padding(10)
                                    Button(action: {
                                        self.isTitleTypeSheetOpen = false
                                    }) {
                                        Text("Ranobe")
                                    }
                                    .padding(10)
                                    
                                }
                                .padding(.bottom, geometry.safeAreaInsets.bottom)
                            }
                            .offset(y: self.offset.height)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in self.onChangedDragValueGesture(value) }
                                    .onEnded { value in self.onEndedDragValueGesture(value) }
                            )
                                .transition(.move(edge: .bottom))
                                .frame(height: self.modalHeight)
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
        .sheet(isPresented: $isFilterSheetOpen) {
            TitleCatalogFilter(
                isFilterVisible: self.$isFilterSheetOpen,
                titleStatus: self.titleStatus,
                animeKind: self.animeKind,
                animeRating: self.animeRating
            ) {
                print(self.titleStatus.toString())
                shikimoriApi.getAnimes(params: AnimesParams(
                    limit: 20,
                    status: self.titleStatus.toString(),
                    kind: self.animeKind.toString(),
                    rating: self.animeRating.toString()
                )) { (animers) in
                    print("\(animers.count)")
                    animers.forEach { anime in
                        print(anime.name)
                    }
                    self.animes = [];
                    self.animes = animers
                }
            }
        }
        .onAppear {
            shikimoriApi.getAnimes(params: AnimesParams()) { (animes) in
                self.animes = animes;
            }
        }
    }
    
    private func onChangedDragValueGesture(_ value: DragGesture.Value) {
        guard value.translation.height > 0 else { return }
        self.offset = value.translation
    }
    
    private func onEndedDragValueGesture(_ value: DragGesture.Value) {
        guard value.translation.height >= self.modalHeight / 2 else {
            self.offset = CGSize.zero
            return
        }
        
        withAnimation {
            self.isTitleTypeSheetOpen = !self.isTitleTypeSheetOpen
            self.offset = CGSize.zero
        }
    }
}

struct TitleCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        TitleCatalogView(animes: [])
    }
}
