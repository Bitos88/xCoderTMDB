//
//  YoutubePlayer.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 18/8/23.
//

import SwiftUI
import WebKit

struct YoutubePlayer: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
