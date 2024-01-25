//
//  Theme+Font.swift
//  
//
//  Created by Nemo on 2024/1/25.
//

import Foundation
import SwiftUI

public extension Font {
    
    /// large titles
    /// ——> 34
    static var themeLargeTitle: Font {
        return themeShared.typography(.largeTitle)
    }
    
    /// The font used for first level hierarchical headings.
    /// ——> 28
    static var themeTitle: Font {
        return themeShared.typography(.title)
    }
    
    /// The font used for second level hierarchical headings.
    /// ——> 22
    static var themeTitle2: Font {
        return themeShared.typography(.title2)
    }
    
    /// The font used for third level hierarchical headings.
    /// ——> 20
    static var themeTitle3: Font {
        return themeShared.typography(.title3)
    }
    
    /// The font used for headings.
    /// ——> 17
    static var themeHeadline: Font {
        return themeShared.typography(.headline)
    }
    
    /// The font used for subheadings.
    /// ——> 15
    static var themeSubheadline: Font {
        return themeShared.typography(.subheadline)
    }
    
    /// The font used for body text.
    /// ——> 17
    static var themeBody: Font {
        return themeShared.typography(.body)
    }
    
    /// The font used for callouts.
    /// ——> 16
    static var themeCallout: Font {
        return themeShared.typography(.callout)
    }
    
    /// The font used in footnotes.
    /// ——> 13
    static var themeFootnote: Font {
        return themeShared.typography(.footnote)
    }
    
    /// The font used for standard captions.
    /// ——> 12
    static var themeCaption: Font {
        return themeShared.typography(.caption)
    }
    
    /// The font used for alternate captions.
    /// ——> 11
    static var themeCaption2: Font {
        return themeShared.typography(.caption2)
    }
}
