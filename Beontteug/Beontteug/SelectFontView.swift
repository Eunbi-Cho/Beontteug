//
//  SelectFontView.swift
//  Beontteug
//
//  Created by 조은비 on 2022/09/01.
//

import SwiftUI

struct SelectFontView: View {
    @State private var multiSelection = Set<UUID>()
    @Binding var fontStyle: String
    let isSelected: Bool = fontStyle? ==
    
    var body: some View {
        List(selection: $multiSelection) {
            Section(header: Text("폰트"), content: {
                HStack {
                    Text("기본 서체")
                        .font(.custom("", size: 24))
                    Spacer()
                    Button(action: {
                        fontStyle = ""
                    }, label: {
                        Image(systemName: "circle")
                            .font(.title2)
                    })
                }
                HStack {
                    Text("배민 한나체 PRO")
                        .font(.custom("BM HANNA Pro", size: 24))
                    Spacer()
                    Button(action: {
                        fontStyle = "BM HANNA Pro"
                    }, label: {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title2)
                    })
                }
                HStack {
                    Text("배민 도현")
                        .font(.custom("BM DoHyeon OTF", size: 20))
                    Spacer()
                    Button(action: {
                        fontStyle = "BM DoHyeon OTF"
                    }, label: {
                        Image(systemName: "circle")
                            .font(.title2)
                    })
                }
                HStack {
                    Text("배민 주아")
                        .font(.custom("BM JUA_OTF", size: 24))
                    Spacer()
                    Button(action: {
                        fontStyle = "BM JUA_OTF"
                    }, label: {
                        Image(systemName: "circle")
                            .font(.title2)
                    })
                }
                HStack {
                    Text("프리텐다드")
                        .font(.custom("Pretendard", size: 24))
                    Spacer()
                    Button(action: {
                        fontStyle = "Pretendard"
                    }, label: {
                        Image(systemName: "circle")
                            .font(.title2)
                    })
                }
                HStack {
                    Text("Yde street 서체")
                        .font(.custom("Yde street", size: 20))
                    Spacer()
                    Button(action: {
                        fontStyle = "Yde street"
                    }, label: {
                        Image(systemName: "circle")
                            .font(.title2)
                    })
                }
            }
            )}
        .listStyle(.plain)
    }
}

//struct SelectFontView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectFontView()
//    }
//}
