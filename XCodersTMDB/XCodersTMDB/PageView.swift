//
//  PageView.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 17/8/23.
//

import SwiftUI

struct PageView: View {
    let page: Page
    
    var body: some View {
        VStack(spacing: 30) {
            Image(page.image)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 250)
                .padding()
                .cornerRadius(30)
                //.border(.blue, width: 10)
                //.background(.white.opacity(0.5))
                .cornerRadius(10)
                .padding()
            
            Text(page.name)
                .font(.title)
            
            Text(page.description)
                .font(.title3)
        }
        .padding()
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(page: .samplePage)
    }
}
