import SwiftUI

struct MacTaskPopoverView {
    private typealias Txt = Str.Task

    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: MacTaskPopoverViewModel
}

extension MacTaskPopoverView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .padding12) {
                topBar

                Group {
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

                    TaskRow(title: Txt.currentColumnLabel, selected: $viewModel.selectedColumn) {
                        ForEach(viewModel.columns, id: \.self) {
                            Text($0.name).tag($0)
                        }
                    }

                    CombinedDatePicker(allDay: $viewModel.allDay, starts: $viewModel.starts, ends: $viewModel.ends)
                        .neumorphic()

                    RepeatBehaviourPicker(startingDate: viewModel.starts, repeatBehaviour: $viewModel.repeatBehaviour)
                }
                .disabled(!viewModel.isEditable)

                stepView

                Button(viewModel.actionButtonLabel, action: viewModel.didTapAction)
                    .buttonStyle(BaseButtonStyle())
            }
            .frame(width: .popoverWidth)
            .padding(.padding32)
        }
        .alert(viewModel.deleteAlertMessage, isPresented: $viewModel.isDeleteAlertPresented) {
            if viewModel.isRepeating {
                Button(Str.Alert.deleteOnlyThis, role: .destructive) {
                    dismiss()
                    DispatchQueue.delayed(viewModel.didTapDelete)
                }
                Button(Str.Alert.deleteAll, role: .destructive) {
                    dismiss()
                    DispatchQueue.delayed(viewModel.didTapDeleteRepeating)
                }
                Button(Str.Alert.cancel, role: .cancel) {}
            } else {
                Button(Str.Alert.delete, role: .destructive) {
                    dismiss()
                    DispatchQueue.delayed(viewModel.didTapDelete)
                }
                Button(Str.Alert.cancel, role: .cancel) {}
            }
        }
        .alert(Str.Alert.updateRepeating, isPresented: $viewModel.isUpdateAlertPresented) {
            Button(Str.Alert.updateAll, action: viewModel.didTapUpdateAll)
            Button(Str.Alert.updateOnlyThis, action: viewModel.didTapUpdateOnlyThis)
        }
        .background(Color.appBackground)
    }
}

extension MacTaskPopoverView {
    var topBar: some View {
        HStack {
            MacIconButton(image: .close) {
                dismiss()
            }
            .buttonStyle(TextButtonStyle())
            Spacer()
            MacIconButton(image: .edit, action: viewModel.didTapEdit)
        }
    }
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
                .contentShape(Rectangle())
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

            if viewModel.isEditable {
                HStack {
                    StyledField(style: .base, title: Txt.stepLabel, text: $viewModel.newStepName)
                    IconButton(.add, action: viewModel.didTapAddStep)
                }
            }
        }
        .padding(.horizontal, .padding4)
    }

    var stepList: some View {
        ScrollView {
            ReorderableList(
                isEditable: viewModel.isEditable,
                items: viewModel.steps,
                deleteAction: { viewModel.didTapDeleteSteps($0) },
                moveAction: viewModel.didMoveStep
            ) { step in
                TaskStepView(
                    step: step,
                    isEditable: viewModel.isEditable,
                    toggleAction: {
                        viewModel.didTapToggle(on: step)
                    },
                    newLabelAcion: {
                        viewModel.didChangeLabel(on: step, to: $0)
                    }
                )
            }
        }
        .frame(height: .defaultListHeight)
    }
}
