import SwiftUI

struct ContentView: View {
    @State private var yiyanCN: String = "获取中..."
    @State private var yiyanEN: String = "Loading..."
    @State private var timer: Timer?
    @State private var opacity: Double = 0.0
    @State private var currentTime: String = ""
    @State private var currentDate: String = ""
    @State private var currentWeekday: String = ""
    @State private var reminderCN: String = "温馨提示加载中..."
    @State private var reminderEN: String = "Loading reminder..."

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                HStack {
                    Text(currentDate)
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                    Text(currentWeekday)
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                    Text(currentTime)
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                }
                .padding(.horizontal)
                
                Spacer()
                
                VStack {
                    Text(formatyiyan(yiyanCN))
                        .padding()
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .opacity(opacity)
                        .animation(.easeInOut(duration: 1.0), value: opacity)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 40)
                    
                    Text(formatyiyan(yiyanEN))
                        .padding()
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .opacity(opacity)
                        .animation(.easeInOut(duration: 1.0), value: opacity)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 40)
                    
                    Spacer()
                    
                    Text(reminderCN)
                        .padding()
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .opacity(opacity)
                        .animation(.easeInOut(duration: 1.0), value: opacity)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 40)
                    
                    Text(reminderEN)
                        .padding()
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .opacity(opacity)
                        .animation(.easeInOut(duration: 1.0), value: opacity)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .onAppear {
                fetchyiyan()
                startTimer()
                updateTimeAndDate()
                updateReminder()
            }
            .onDisappear {
                stopTimer()
            }
        }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            fetchyiyan()
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func fetchyiyan() {
        let url = URL(string: "https://api.kekc.cn/api/yien")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            do {
                let yiyanResponse = try JSONDecoder().decode(yiyanResponse.self, from: data)
                DispatchQueue.main.async {
                    withAnimation {
                        opacity = 0.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        yiyanCN = yiyanResponse.cn
                        yiyanEN = yiyanResponse.en
                        withAnimation {
                            opacity = 1.0
                        }
                    }
                }
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

    func updateTimeAndDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM月dd日"
        currentDate = dateFormatter.string(from: Date())

        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.dateFormat = "EEEE"
        currentWeekday = dateFormatter.string(from: Date())

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            currentTime = timeFormatter.string(from: Date())
        }
    }

    func updateReminder() {
        let currentHour = Calendar.current.component(.hour, from: Date())
        
        switch currentHour {
        case 6...8:
            reminderCN = "早上好！以积极的心态和健康的早餐开始新的一天。"
            reminderEN = "Good morning! Start your day with a positive mindset and a healthy breakfast."
        case 9...11:
            reminderCN = "记得每小时短暂休息，伸展一下腿脚。"
            reminderEN = "Remember to take short breaks and stretch your legs every hour."
        case 12...13:
            reminderCN = "午餐时间到了！休息一下，享用营养丰富的午餐。"
            reminderEN = "It's lunchtime! Take a break and enjoy a nutritious meal."
        case 14...17:
            reminderCN = "保持水分，短暂散步以清新头脑。"
            reminderEN = "Stay hydrated and take a short walk to refresh your mind."
        case 18...20:
            reminderCN = "结束一天的工作，进行一些轻松的运动或活动。"
            reminderEN = "Wind down your day with some light exercise or a relaxing activity."
        case 21...22:
            reminderCN = "准备好好睡一觉，避免使用屏幕，放松心情。"
            reminderEN = "Prepare for a good night's sleep by avoiding screens and relaxing your mind."
        default:
            reminderCN = "照顾好自己，保持积极的心态！"
            reminderEN = "Take care of yourself and stay positive!"
        }
    }

    func formatyiyan(_ text: String) -> String {
        let punctuationSet: Set<Character> = [".", "。", "!", "！", "?", "？", ",", "，", ";", "；", ":", "："]
        var formattedText = ""
        for character in text {
            formattedText.append(character)
            if punctuationSet.contains(character) {
                formattedText.append("\n")
            }
        }
        return formattedText
    }
}

struct yiyanResponse: Codable {
    let cn: String
    let en: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
