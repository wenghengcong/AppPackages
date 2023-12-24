import SwiftUI

public struct HCEmptyView: View {
  public let iconName: String
  public let title: LocalizedStringKey
  public let message: LocalizedStringKey

  public init(iconName: String, title: LocalizedStringKey, message: LocalizedStringKey) {
    self.iconName = iconName
    self.title = title
    self.message = message
  }

  public var body: some View {
    VStack {
      Image(systemName: iconName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxHeight: 50)
      Text(title)
        .font(.title)
        .padding(.top, 16)
      Text(message)
        .font(.subheadline)
        .multilineTextAlignment(.center)
        .foregroundColor(.gray)
    }
    .padding(.top, 100)
    .padding(.layoutPadding)
    .fixedSize(horizontal: false, vertical: true)
  }
}
