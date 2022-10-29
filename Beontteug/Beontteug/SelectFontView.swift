//
//  SelectFontView.swift
//  Beontteug
//
//  Created by 조은비 on 2022/09/01.
//

import SwiftUI

struct SelectFontView: View {
    
    @State private var fonts = [
        FontList(fontName: "기본 서체", fontStyle: ""),
        FontList(fontName: "배민 한나체", fontStyle: "BM HANNA Pro"),
        FontList(fontName: "배민 도현", fontStyle: "BM DoHyeon OTF"),
        FontList(fontName: "배민 주아", fontStyle: "BM JUA_OTF"),
        FontList(fontName: "프리텐다드", fontStyle: "Pretendard"),
        FontList(fontName: "Yde 스트리트 서체", fontStyle: "Yde street")
    ]
    
    @State private var multiSelection = Set<UUID>()
    @Binding var fontStyle: String
    @Binding var isToggled: [Bool]
    
    var body: some View {
        List(selection: $multiSelection) {
            ForEach(fonts.indices, id: \.self) { idx in
                    HStack {
                        Text(fonts[idx].fontName)
                            .font(.custom(fonts[idx].fontStyle, size: 24))
                            .frame(height: 40)
                        Spacer()
                        Button(action: {
                            fontStyle = fonts[idx].fontStyle
                        }, label: {
                            Image(systemName: fontStyle == fonts[idx].fontStyle ? "checkmark.circle.fill" : "circle")
                                .font(.title2)
                        })
                    }
                }
        }
        .listStyle(.plain)
        .padding(.top, 20)
    }
}

//struct SelectFontView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectFontView()
//    }
//}
