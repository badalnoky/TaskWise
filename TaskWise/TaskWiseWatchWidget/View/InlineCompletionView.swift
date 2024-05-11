import SwiftUI

struct InlineCompletionView: View {
    var entry: CompletionProvider.Entry

    var body: some View {
        Text(Str.Watch.Widget.inline(entry.completedTasks, entry.totalTasks))
    }
}
