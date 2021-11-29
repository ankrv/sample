import SwiftUI

struct SubscriptionView: View {
  let hasSubscribed = viewModel?.hasSubscribed() ?? false
  @State var updatedPrice = price
  var body: some View {
    ZStack{
      Image("subBackground")
        .resizable()
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        Spacer()
        Image("logoForSub")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 333, height: 105)
          .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
        Spacer()
        GeometryReader { geometry in
          ScrollView(.vertical) {
            VStack {
              Text(NSLocalizedString("subText", comment: ""))
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.semibold)
                .shadow(color: Color(.displayP3, red: 60/255, green: 88/255, blue: 111/255, opacity: 1), radius: 4, x: 0, y: 0)
                .lineSpacing(20)
                .frame(maxWidth: 400)
            }
            .padding()
            .frame(width: geometry.size.width)
            .frame(minHeight: geometry.size.height)
          }
        }
        
        Spacer()
        Button(action: buySubAndDismissSubScreen) {
          
          if hasSubscribed {
            Text(NSLocalizedString("thankYouForPurchase", comment: ""))
              .foregroundColor(.white)
              .font(.title)
              .fontWeight(.semibold)
              .multilineTextAlignment(.center)
              .shadow(color: Color(.displayP3, red: 60/255, green: 88/255, blue: 111/255, opacity: 1), radius: 4, x: 0, y: 0)
              .padding() // 16 is default here
              .frame(minWidth: 0, maxWidth: .infinity)
              .lineSpacing(0)
              .overlay(
                RoundedRectangle(cornerRadius: 20)
                  .stroke(Color.white, lineWidth: 1)
              )
            
          } else {
            Text(String(format: NSLocalizedString("monthBuyFor", comment: ""), updatedPrice))
              .foregroundColor(.white)
              .font(.title)
              .fontWeight(.semibold)
              .multilineTextAlignment(.center)
              .shadow(color: Color(.displayP3, red: 60/255, green: 88/255, blue: 111/255, opacity: 1), radius: 4, x: 0, y: 0)
              .padding() // 16 is default here
              .frame(minWidth: 0, maxWidth: .infinity)
              .lineSpacing(0)
              .overlay(
                RoundedRectangle(cornerRadius: 20)
                  .stroke(Color.white, lineWidth: 1)
              )
            // Only gets called after the initial UI has been loaded - to get the price after some connection problem
              .onReceive(NotificationCenter.default.publisher(for: Notification.Name("priceUpdated"))) { info in
                self.updatedPrice = info.userInfo!["price"] as! String
              }
          }
        }
        .padding()
        
        HStack {
          Button(action: {
            viewModel?.showPrivacyPolicy()
          }) {
            Text(NSLocalizedString("Privacy", comment: ""))
              .foregroundColor(.white)
              .font(.body)
              .fontWeight(.regular)
              .multilineTextAlignment(.center)
              .shadow(color: Color(.displayP3, red: 60/255, green: 88/255, blue: 111/255, opacity: 1), radius: 4, x: 0, y: 0)
              .lineSpacing(0)
          }
          if hasSubscribed {
            Button(action: {
              viewModel?.cancelSub()
            }) {
              Text(NSLocalizedString("cancelSub", comment: ""))
                .foregroundColor(.white)
                .font(.body)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
                .shadow(color: Color(.displayP3, red: 60/255, green: 88/255, blue: 111/255, opacity: 1), radius: 4, x: 0, y: 0)
                .lineSpacing(0)
            }
            
          } else {
            Button(action: {
              viewModel?.restoreSub()
            }) {
              Text(NSLocalizedString("restorePurchaseSubScreenLabel", comment: ""))
                .foregroundColor(.white)
                .font(.body)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
                .shadow(color: Color(.displayP3, red: 60/255, green: 88/255, blue: 111/255, opacity: 1), radius: 4, x: 0, y: 0)
                .lineSpacing(0)
            }
          }
          
          Button(action: {
            viewModel?.showTerms()
          }) {
            Text(NSLocalizedString("Terms", comment: ""))
              .foregroundColor(.white)
              .font(.body)
              .fontWeight(.regular)
              .multilineTextAlignment(.center)
              .shadow(color: Color(.displayP3, red: 60/255, green: 88/255, blue: 111/255, opacity: 1), radius: 4, x: 0, y: 0)
              .lineSpacing(0)
          }
        }
        Spacer()
      }
      
      HStack {
        VStack(alignment: .leading) {
          Button(action: closeSubScreen) {
            Image(systemName: "xmark").font(.system(size: 35).weight(.ultraLight))
              .foregroundColor(.white)
              .padding()
          }
          Spacer()
        }
        Spacer()
      }
    }
  }
}

struct SubScreen_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SubscriptionView()
        .previewDevice("iPod touch (7th generation)")
    }
  }
}
