import SwiftUI

struct MenuListView: View {
    @EnvironmentObject var vm: iPodViewModel
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(Array(vm.currentMenuItems.enumerated()), id: \.element.id) { index, item in
                        MenuRowView(title: item.title, isSelected: index == vm.selectedIndex)
                            .id(index)
                    }
                }
            }
            .onChange(of: vm.selectedIndex) { _, newIndex in
                withAnimation {
                    proxy.scrollTo(newIndex, anchor: .center)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(vm.currentTheme.screenBackground)
    }
}
