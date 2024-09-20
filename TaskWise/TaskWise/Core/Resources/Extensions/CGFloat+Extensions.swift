import Foundation

public extension CGFloat {
    /// 2 pt
    static let borderWidth: CGFloat = 2
    /// 3 pt
    static let mutedShadowRadius: CGFloat = 3
    /// 4 pt
    static let shadowRadius: CGFloat = 4
    /// 5 pt
    static let orderIndicatorRectangleWidth: CGFloat = 5
    /// 5 pt
    static let listCategoryWidth: CGFloat = 5
    /// 8 pt
    static let cornerRadius: CGFloat = 8
    /// 9 pt
    static let widgetIndicatorWidth: CGFloat = 9
    /// 10 pt
    static let orderIndicatorOffset: CGFloat = 10
    /// 12
    static let indicatorBorderWidth: CGFloat = 12
    /// 13
    static let listButtonPadding: CGFloat = 13
    /// 20
    static let minimumDragDistance: CGFloat = 20
    /// 20
    static let widgetFontSize: CGFloat = 20
    /// 25 pt
    static let defaultIconSize: CGFloat = 25
    /// 25 pt
    static let shadowLineWidth: CGFloat = 25
    /// 28 pt
    static let defaultColorPickerSize: CGFloat = 28
    /// 30 pt
    static let defaultCheckboxSize: CGFloat = 30
    /// 35 pt
    static let iconButtonSize: CGFloat = 35
    /// 44 pt
    static let defaultRowHeight: CGFloat = 44
    /// 50 pt
    static let listItemHeight: CGFloat = 50
    /// 80 pt
    static let listDeleteButtonMaxWidth: CGFloat = 80
    /// 200 pt
    static let defaultListHeight: CGFloat = 200
    /// 260 pt
    static let defaultFilterSheetHeight: CGFloat = 260
    /// 400 pt
    static let popoverWidth: CGFloat = 400
    /// 600 pt
    static let macMinSize: CGFloat = 600
    /// 800 pt
    static let popoverMinHeight: CGFloat = 800
}

public extension CGFloat {
    /// 4 pt
    static let padding4: CGFloat = 4
    /// 8 pt
    static let padding8: CGFloat = 8
    /// 6 pt
    static let padding6: CGFloat = 6
    /// 12 pt
    static let padding12: CGFloat = 12
    /// 16 pt
    static let padding16: CGFloat = 16
    /// 24 pt
    static let padding24: CGFloat = 24
    /// 32 pt
    static let padding32: CGFloat = 32
    /// 50 pt
    static let padding50: CGFloat = 50
}

public extension CGFloat {
    /// 0.2 pt
    static let indicatorLowerBound: CGFloat = 0.2
    /// 0.6 pt
    static let indicatorRange: CGFloat = 0.6
    /// 0.8 pt
    static let indicatorGreaterBound: CGFloat = 0.8
}

public extension CGFloat {
    /// 25 pt
    static let pageButtonHeight: CGFloat = 25
    /// 30 pt
    static let widgetHeaderHeight: CGFloat = 30
    /// 40 pt
    static let columnButtonWidth: CGFloat = 40
}

extension CGFloat {
    static let one: CGFloat = 1
    static let indicitorWidgetCircularWidth: CGFloat = 9
    static let indicitorWidgetRectangularWidth: CGFloat = 7
    static let maxColorValue: CGFloat = 255
    static let indicatorWidgetSize: CGFloat = 40
}

public extension CGFloat {
    /// 0.2
    static let watchIndicatorLowerBound: CGFloat = 0.2
    /// 0.6
    static let watchIndicatorRange: CGFloat = 0.6
    /// 0.8
    static let watchIndicatorGreaterBound: CGFloat = 0.8
    /// 4 pt
    static let watchIndicatorMinLineWidth: CGFloat = 4
    /// 12 pt
    static let watchIndicatorMaxLineWidth: CGFloat = 12

    static let watchIndicatorLineWidthRange: CGFloat = watchIndicatorMaxLineWidth - watchIndicatorMinLineWidth
    /// 70 pt
    static let watchIndicatorMinWidth: CGFloat = 70
    /// 185 pt
    static let watchIndicatorMaxWidth: CGFloat = 185

    static let watchIndicatorWidthRange = watchIndicatorMaxWidth - watchIndicatorMinWidth
    /// 10 pt
    static let watchIndicatorMinFontSize: CGFloat = 10
    /// 34 pt
    static let watchIndicatorMaxFontSize: CGFloat = 34

    static let watchIndicatorFontRange = watchIndicatorMaxFontSize - watchIndicatorMinFontSize
    /// 25 pt
    static let watchMinimumTextSpace: CGFloat = 25
    /// 0.1
    static let watchCompletionScale: CGFloat = 0.1
    /// 40 pt
    static let watchCategoryColorHeight: CGFloat = 40
    /// 20 pt
    static let watchStepIndicatorSize: CGFloat = 20
}

public extension CGFloat {
    var half: CGFloat {
        self / 2
    }

    var negative: CGFloat {
        self * -1
    }

    var third: CGFloat {
        self / 3
    }
}
