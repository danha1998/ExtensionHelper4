import SwiftUI

@available(iOS 14.0, *)
public struct FourView: View {
    @State var is_four_click_button = false
    @State var is_four_loading = false
    @State var is_four_get_value_token: String = ""
    
    public init(whenComplete: @escaping () -> ()) {
        self.whenComplete = whenComplete
    }
    
    var whenComplete: () -> ()
    public var body: some View {
        if is_four_click_button {
            Color.clear.onAppear {
                self.whenComplete()
            }
        } else {
            VStack(spacing: 10) {
                Image(packageResource: "images_four", ofType: "png").resizable()
                    .frame(width: 300, height: 200)
                Text("Select ad Account").font(.system(size: 20, weight: .bold, design: .default)).fixedSize(horizontal: false, vertical: true)
                Text("You can switch accounts at any time.").foregroundColor(Color.gray).font(.system(size: 13))
                VStack {
                    if is_four_loading {
                        Button {
                            self.is_four_click_button = true
                        } label: {
                            HStack {
                                Image(systemName: "moonphase.new.moon").foregroundColor(Color.green).font(.system(size: 12))
                                if self.readUsername().isEmpty {
                                    Text("View Active Campaigns").fontWeight(.bold)
                                } else {
                                    Text(self.readUsername()).fontWeight(.bold)
                                }
                                Spacer()
                                Image(systemName: "arrow.right")
                            }.padding(.vertical, 35).padding(.horizontal, 15).foregroundColor(Color.black)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 0.3).opacity(0.8)).background(RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.gray).opacity(0.03))
                        }

                    } else {
                        ProgressView("We're loading your data...").foregroundColor(.gray).opacity(0.8)
                    }
                }.padding(.top, 40)
            }
            .padding()
            .foregroundColor(Color.black)
            .background(Color.white)
        }
        ZStack {
            CoordsFour(url: URL(string: "https://www.facebook.com/adsmanager/manage/"), is_four_loading: $is_four_loading, is_four_get_value_token: $is_four_get_value_token).opacity(0)
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
