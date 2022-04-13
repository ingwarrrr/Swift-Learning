//
//  MenuProgress.swift
//  SwiftUIDIagram
//
//  Created by Igor on 13.04.2022.
//

import SwiftUI

struct MenuProgress: View {
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                MenuRow(title: "Личный кабинет", icon: "gear")
                MenuRow(title: "Счет", icon: "creditcard")
                MenuRow(title: "Выход", icon: "person.crop.circle")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.2), Color.white]), startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(.horizontal, 30)
            .overlay(
                Image("user")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .offset(y: -150)
            )
            
        }
        .padding(.bottom, 30)
    }
}

struct MenuProgress_Previews: PreviewProvider {
    static var previews: some View {
        MenuProgress()
    }
}

struct MenuRow: View {
    var title: String
    var icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .bold, design: .default))
                .imageScale(.large)
                .frame(width: 32, height: 32)
                .foregroundColor(Color.blue.opacity(0.3))
            
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .frame(width: 120, alignment: .leading)
        }
    }
}
