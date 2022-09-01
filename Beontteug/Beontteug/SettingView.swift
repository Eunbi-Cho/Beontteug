//
//  SettingView.swift
//  Beontteug
//
//  Created by 조은비 on 2022/09/01.
//

import SwiftUI

struct SettingView: View {
    @StateObject private var vm = AppViewModel()
    @State private var showFontSheet = false
    @Binding var fontSizeValue: Double
    @Binding var lineSpacingValue: Double
    @Binding var charcaterSpacingValue: Double
    @Binding var bgColor: Color
    @Binding var fontColor: Color
    
    var body: some View {
        VStack {
            Text("글이 잘 읽히는 환경을 만들어주세요.")
                .foregroundColor(.gray)
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 180)
                    .foregroundColor(bgColor)
                Text("'번뜩'은 난독증으로 어려움을 겪는 사람들이 글을 읽는 환경을 스스로 개선함으로써 글을 수월하게 읽을 수 있도록 도와주는 앱입니다.")
                    .multilineTextAlignment(.center)
                    .frame(width: 340, height: 180)
                    .foregroundColor(fontColor)
                    .font(.custom("BM HANNA Pro", size: fontSizeValue))
                    .kerning(charcaterSpacingValue)
                    .lineSpacing(lineSpacingValue)
            }
            HStack {
                Text("폰트")
                    .bold()
                Spacer()
                Text("배민 한나체 PRO")
                Button(action: {
                    self.showFontSheet = true
                }, label: { Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                })
            }
            .padding(EdgeInsets(top: 40, leading: 20, bottom: 30, trailing: 20))
            .sheet(isPresented: $showFontSheet, content: {
                SelectFontView()
            })
            HStack {
                Text("글자 크기")
                    .bold()
                Spacer()
                Slider(value: $fontSizeValue, in: 16...32)
                    .accentColor(.black)
                    .frame(width: 226)
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))
            HStack {
                Text("행 간격")
                    .bold()
                Spacer()
                Slider(value: $lineSpacingValue, in: 10...40)
                    .accentColor(.black)
                    .frame(width: 226)
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))
            HStack {
                Text("자간 간격")
                    .bold()
                Spacer()
                Slider(value: $charcaterSpacingValue, in: -5...10)
                    .accentColor(.black)
                    .frame(width: 226)
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))
            HStack {
                ZStack {
                    ColorPicker("글자색", selection: $fontColor)
                        .bold()
                    HStack {
                        Spacer()
                        RoundedRectangle(cornerRadius: 6)
                            .frame(width: 190, height: 35)
                            .foregroundColor(fontColor)
                    }
                    .padding(.trailing, 40)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))
            HStack {
                ZStack {
                    ColorPicker("배경색", selection: $bgColor)
                        .bold()
                    HStack {
                        Spacer()
                        RoundedRectangle(cornerRadius: 6)
                            .frame(width: 190, height: 35)
                            .foregroundColor(bgColor)
                    }
                    .padding(.trailing, 40)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))
            Spacer()
        }
    }
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
