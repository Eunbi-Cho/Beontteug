//
//  SelectFontView.swift
//  Beontteug
//
//  Created by 조은비 on 2022/09/01.
//

import SwiftUI

struct SelectFontView: View {
    var body: some View {
        VStack {
            HStack {
                Text("선호하는 폰트를 선택해주세요")
                    .bold()
                Spacer()
            }
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
            List {
                    Text("기본 서체")
                    Text("배민 한나체 PRO")
                        .font(Font.customTitle())
                    Text("무슨 서체로 할까")
                }
            .listStyle(.inset)
        }
        .padding(.top, 40)
        }
    }

struct SelectFontView_Previews: PreviewProvider {
    static var previews: some View {
        SelectFontView()
    }
}
