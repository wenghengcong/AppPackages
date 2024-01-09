

import SwiftUI

public extension UICalendarView.Decoration {
	
	static func `default`(color: Color, size: UICalendarView.DecorationSize = .medium) -> UICalendarView.Decoration {
		.default(color: UIColor(color), size: size)
	}
	
	static func customView(_ customView: @escaping () -> some View) -> Self {
		.customView {
			let view = UIHostingController(rootView: customView()).view!
			view.backgroundColor = .clear
			return view
		}
	}
}
