import SwiftUI

struct AddTaskPopoverView {
    private typealias Txt = Str.Task

    @Bindable var viewModel: AddTaskPopoverViewModel

    init() {
        self.viewModel = AddTaskPopoverViewModel()
    }
}
extension AddTaskPopoverView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .padding12) {
                titleAndDescriptionView

                TaskRow(title: Txt.priorityLabel, selected: $viewModel.selectedPriority) {
                    ForEach(viewModel.priorities, id: \.level) {
                        Text($0.name).tag($0)
                    }
                }

                TaskRow(title: Txt.categoryLabel, selected: $viewModel.selectedCategory) {
                    ForEach(viewModel.categories, id: \.self) {
                        Text($0.name).tag($0)
                    }
                }

                TaskRow(title: Txt.startingColumnLabel, selected: $viewModel.selectedColumn) {
                    ForEach(viewModel.columns, id: \.self) {
                        Text($0.name).tag($0)
                    }
                }

                CombinedDatePicker(allDay: $viewModel.allDay, starts: $viewModel.starts, ends: $viewModel.ends)
                    .neumorphic()

                RepeatBehaviourPicker(startingDate: viewModel.starts, repeatBehaviour: $viewModel.repeatBehaviour)

                stepView

                Button(Txt.createButtonLabel, action: viewModel.didTapCreate)
                    .buttonStyle(BaseButtonStyle())
            }
            .frame(width: .popoverWidth)
            .padding(.padding32)
        }
        .background(Color.appBackground)
    }
}

extension AddTaskPopoverView {
    var titleAndDescriptionView: some View {
        VStack(spacing: .padding12) {
            StyledField(style: .title, title: Txt.titleLabel, text: $viewModel.title)

            StyledField(style: .description, title: Txt.descriptionLabel, text: $viewModel.description)
        }
        .padding(.padding4)
        .neumorphic()
    }

    var stepView: some View {
        VStack(spacing: .padding12) {
            VStack(spacing: .padding12) {
                HStack {
                    StyledText(text: Txt.stepsLabel, style: .base)
                        .frame(height: .defaultRowHeight)
                        .padding(.leading, .padding4)
                    Image(systemName: viewModel.isStepViewExpanded ? Str.Icons.down : Str.Icons.forward)
                        .contentTransition(.symbolEffect(.replace.wholeSymbol))
                        .foregroundStyle(.accent)
                        .padding(.trailing, .padding4)
                }
                .onTapGesture {
                    withAnimation {
                        viewModel.isStepViewExpanded.toggle()
                    }
                }

                if viewModel.isStepViewExpanded {
                    stepList
                }
            }
            .neumorphic()

            if viewModel.isStepViewExpanded {
                HStack {
                    StyledField(style: .base, title: Txt.stepLabel, text: $viewModel.newStepName)
                    IconButton(.add, action: viewModel.didTapAddStep)
                        .padding(.trailing, .padding4)
                }
            }
        }
    }

    var stepList: some View {
        ScrollView {
            ForEach($viewModel.steps, id: \.self) { $step in
                ListItemView(
                    isEditable: true,
                    deleteAction: {  }
                ) {
                    HStack {
                        StepIcon(isDone: step.isDone)
                            .onTapGesture {
                                withAnimation {  }
                            }
                        TextField(String.empty, text: $step.label)
                            .textFieldOverlay()
                            .textStyle(.body)
                    }
                    .padding(.horizontal, .padding4)
                }
            }
            .padding(.horizontal, .padding12)
        }
        .frame(height: .defaultListHeight)
    }
}

#Preview {
    AddTaskPopoverView()
}