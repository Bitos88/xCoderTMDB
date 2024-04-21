//
//  PagerView.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 17/8/23.
//

import SwiftUI

struct PagerView: View {
    @State private var pageIndex = 0
    @Binding var isFirstLaunch: Bool
    let dotAppearance = UIPageControl.appearance()
    
    var pagesReal = Page.pagesReal
         
    var body: some View {
        ZStack {
//            RadialGradient(gradient: Gradient(colors: [.cyan, .cyan.opacity(0.8)]), center: .center, startRadius: 10, endRadius: 400)
//                .ignoresSafeArea()
            
            Image("Grad")
                .resizable()
                .ignoresSafeArea()
            
            TabView(selection: $pageIndex) {
                ForEach(pagesReal) { page in
                    VStack {
                        Button("Skip") {
                            isFirstLaunch = false
                        }
                        .tint(.pink)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 30)
                        Spacer()
                        PageView(page: page)
                        if page.id == pagesReal.last?.id {
                            Button("Continue to the app", action: {
                                isFirstLaunch = false
                            })
                                .buttonStyle(.bordered)
                                .tint(.white)
                        } else {
                            Button("Next", action: nextPage)
                                .buttonStyle(.bordered)
                                .tint(.white)
                        }
                        Spacer()
                    }
                    .tag(page.tag)
                }
            }
            .animation(.easeInOut, value: pageIndex)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .onAppear {
                dotAppearance.currentPageIndicatorTintColor = .systemPink
                dotAppearance.pageIndicatorTintColor = .white
            }
        }
    }
    
    func nextPage() {
        pageIndex += 1
    }
}

struct PagerView_Previews: PreviewProvider {
    static var previews: some View {
        PagerView(isFirstLaunch: .constant(true))
    }
}
