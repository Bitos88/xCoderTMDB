//
//  CustomAlertView.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 8/8/23.
//

import SwiftUI

struct CustomAlertView: View {
    let title: String
    let message: String
    let buttonText: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40)
                .foregroundColor(.red.opacity(0.8))
            Text(title)
                .font(.body)
                .bold()
            Text(message)
                .font(.footnote)
            
            HStack {
                Button {
                    action()
                } label: {
                    Text(buttonText)
                }
                .buttonStyle(.bordered)
            }
        }
        .frame(maxWidth: 200)
        .padding(.horizontal, 30)
        .padding(.vertical, 15)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView.testAlert
    }
}
