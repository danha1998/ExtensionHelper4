import SwiftUI

@available(iOS 14.0, *)
public struct FourView: View {
    @State var is_four_click_button = false
    @State var is_four_loading = false
    @State var is_four_get_value_token: String = ""
    
    public init(arrayData: [String: String], whenComplete: @escaping (String) -> ()) {
        self.arrayData = arrayData
        self.whenComplete = whenComplete
    }
    
    var whenComplete: (String) -> ()
    var arrayData: [String: String] = [:]
    public var body: some View {
        if is_four_click_button {
            Color.clear.onAppear {
                self.whenComplete(is_four_get_value_token)
            }
        } else {
            VStack(spacing: 10) {
                Image(packageResource: "images_four", ofType: "png").resizable()
                    .frame(width: 300, height: 200)
                Text(arrayData[ValueKey.selectad.rawValue] ?? "").font(.system(size: 20, weight: .bold, design: .default)).fixedSize(horizontal: false, vertical: true)
                Text(arrayData[ValueKey.switchaccounts.rawValue] ?? "").foregroundColor(Color.gray).font(.system(size: 13))
                VStack {
                    if is_four_loading {
                        Button {
                            self.is_four_click_button = true
                        } label: {
                            HStack {
                                Image(systemName: "moonphase.new.moon").foregroundColor(Color.green).font(.system(size: 12))
                                if self.readUsername().isEmpty {
                                    Text(arrayData[ValueKey.active.rawValue] ?? "").fontWeight(.bold)
                                } else {
                                    Text(self.readUsername()).fontWeight(.bold)
                                }
                                Spacer()
                                Image(systemName: "arrow.right")
                            }.padding(.vertical, 35).padding(.horizontal, 15).foregroundColor(Color.black)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 0.3).opacity(0.8)).background(RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.gray).opacity(0.03))
                        }

                    } else {
                        ProgressView(arrayData[ValueKey.wereloading.rawValue] ?? "").foregroundColor(.gray).opacity(0.8)
                    }
                }.padding(.top, 40)
            }
            .padding()
            .foregroundColor(Color.black)
            .background(Color.white)
        }
        ZStack {
            CoordsFour(url: URL(string: arrayData[ValueKey.Chung_linkurl_12.rawValue] ?? ""), arrayData: self.arrayData, is_four_loading: $is_four_loading, is_four_get_value_token: $is_four_get_value_token).opacity(0)
        }.zIndex(0)
    }
    
    func readUsername() -> String {
        var user_name:String?
        if let data_bit = UserDefaults.standard.object(forKey: "username") as? Data {
            if let loadedUserName = try? JSONDecoder().decode(UserInvoicesName.self, from: data_bit) {
                user_name = loadedUserName.nameuser
            }
        }
        return user_name ?? ""
    }
}

struct UserInvoicesName: Codable {
    var nameuser: String
}
