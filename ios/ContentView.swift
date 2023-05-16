//
//  ContentView.swift
//  C_Mega_Menu
//
//  Created by 이성민 on 2023/05/13.
//

import SwiftUI

struct CarouselExapleView: View {
    @State private var cards : [Card] = []
    @State var menus: [Menu] = []
    @State private var currentIndex: Int = 0
    
    private let itemWidth: CGFloat = UIScreen.main.bounds.width * 0.7
    
    var body: some View {
        VStack {
                
            //            Text("Hello card \(currentIndex)")
            //                .fontWeight(.semibold)
            //                .padding()
            if !cards.isEmpty {
                
                if let period = menus.first?.Period {
                    Text("구내식당 " + period + " 메뉴 🧑‍🍳")
                        .padding(.top, 10)
                        .font(Font.custom("나눔손글씨 맛있는체", size: 26))
                    
                    Text("(날짜만 적힌 날은 점심 식사를 제공하지 않습니다)")
                        .padding(.bottom, 70)
                        .font(Font.custom("나눔손글씨 맛있는체", size: 18))
                    
                }
                
                CarouselView(items: cards, spacing: 100, currentIndex: $currentIndex) { item in

                    
//                    Text(item.date + "\n\n" + item.caption)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
//                        .frame(width: itemWidth, height: 450)
//                        .background(item.color)
//                        .cornerRadius(12)
//                        .scaleEffect(currentIndex == cards.firstIndex(of: item) ? 1 : 0.95)
//                        .font(Font.custom("나눔손글씨 맛있는체", size: 22))
                    VStack(alignment: .center, spacing: 0) {
                            Text(item.date)
                                //.padding(.top, 25)
                                //.fontWeight(.semibold) // ios 16이상
                                .foregroundColor(.white)
                                .font(Font.custom("나눔손글씨 맛있는체", size: 28))
                            Text(item.caption)
                                //.fontWeight(.semibold) // ios 16이상
                                .foregroundColor(.white)
                                .font(Font.custom("나눔손글씨 맛있는체", size: 26))
                                .frame(width: itemWidth, height: 380)
                        }
                        .frame(width: itemWidth, height: 450)
                        .background(item.color)
                        .cornerRadius(12)
                        .scaleEffect(currentIndex == cards.firstIndex(of: item) ? 1 : 0.95)
                }
                .shadow(radius: 5)
                
                Text("점심 식사 맛있게 드세요 🍴")
                    .padding(.top, 70)
                    .font(Font.custom("나눔손글씨 맛있는체", size: 22))
                    
                Text("(메뉴 업데이트는 주1회 입니다)")
                    .padding(.bottom, 10)
                    .font(Font.custom("나눔손글씨 맛있는체", size: 22))
                    
            }
        }
        .multilineTextAlignment(.center)
        .onAppear {
            loadData()
            currentIndex = getInitialIndex()
        }
        //.navigationTitle("Carousel")
        
    }
    private func loadData() {
        guard let url = URL(string: "AWS API Gateway URL") else {
            return
        }
            
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Menu].self, from: data)
                    DispatchQueue.main.async {
                        menus = decodedResponse
                    }
                        
                    let colors: [Color] = [Color(red: 60/255, green: 144/255, blue: 207/255), Color(red: 71/255, green: 141/255, blue: 194/255), Color(red: 82/255, green: 138/255, blue: 181/255), Color(red: 94/255, green: 136/255, blue: 167/255), Color(red: 105/255, green: 133/255, blue: 154/255)]
                       cards = decodedResponse.enumerated().map { index, menus in
                           let temp1 = menus.Menu.components(separatedBy: "\n")[0]
                           let menu_date = temp1.components(separatedBy: " ")[1] + " " + temp1.components(separatedBy: " ")[2]
                           let temp2 = menus.Menu.components(separatedBy: "\n")[1...]
                           let menu_info = temp2.joined(separator: "\n")
//                           print(temp1)
//                           print(temp2)
//                           print(menu_info)
                           return Card(caption: menu_info, date: menu_date, color: colors[index % colors.count])
                       }
                        
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    // 일1, 월2, 화3, 수4, 목5, 금6, 토7
    private func getInitialIndex() -> Int {
        let today = Calendar.current.component(.weekday, from: Date())
        switch today {
        case 2: // 월요일
            return 0
        case 3: // 화요일
            return 1
        case 4: // 수요일
            return 2
        case 5: // 목요일
            return 3
        case 6: // 금요일
            return 4
        default: // 토요일, 일요일
            return 0
        }
    }
}

struct Menu: Codable {
    let Period: String
    let Menu: String
}

struct CarouselExapleView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselExapleView()
    }
}
