import SwiftUI

struct VirtualMachineListView: View {
    @StateObject private var viewModel = VirtualMachineListViewModel()
    @State private var showingAddVM = false
    @State private var selectedVM: VirtualMachine?
    @State private var showingDeleteConfirmation = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.virtualMachines) { vm in
                    VirtualMachineRow(vm: vm)
                        .contextMenu {
                            Button {
                                selectedVM = vm
                                showingDeleteConfirmation = true
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                            if vm.status.isRunning {
                                Button {
                                    viewModel.stopVirtualMachine(withID: vm.id)
                                } label: {
                                    Label("Stop", systemImage: "stop.circle")
                                }
                            } else {
                                Button {
                                    viewModel.startVirtualMachine(withID: vm.id)
                                } label: {
                                    Label("Start", systemImage: "play.circle")
                                }
                            }
                        }
                        .contentShape(Rectangle())
                }
                .onDelete { indexSet in
                    viewModel.deleteVirtualMachine(atOffsets: indexSet)
                }
            }
            .navigationTitle("Virtual Machines")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button {
                        showingAddVM = true
                    } label: {
                        Label("Add VM", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddVM) {
                AddVirtualMachineView { newVM in
                    viewModel.addVirtualMachine(newVM)
                    showingAddVM = false
                }
            }
            .alert("Delete Virtual Machine", isPresented: $showingDeleteConfirmation) {
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    if let vm = selectedVM {
                        viewModel.deleteVirtualMachine(withID: vm.id)
                    }
                }
            } message: {
                Text("Are you sure you want to delete this virtual machine? This action cannot be undone.")
            }
        }
        .frame(minWidth: 600, minHeight: 400)
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct VirtualMachineRow: View {
    let vm: VirtualMachine
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(vm.name)
                    .font(.headline)
                Spacer()
                statusView
            }
            
            if let ipAddress = vm.ipAddress {
                Text("IP: \(ipAddress)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text("CPU: \(vm.cpuCores) cores | Memory: \(vm.memoryGB) GB")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
    
    private var statusView: some View {
        HStack {
            Circle()
                .fill(statusColor)
                .frame(width: 10, height: 10)
            Text(vm.status.rawValue)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
    
    private var statusColor: Color {
        switch vm.status {
        case .running:
            return .green
        case .stopped:
            return .red
        case .paused:
            return .orange
        }
    }
}

struct VirtualMachineListView_Previews: PreviewProvider {
    static var previews: some View {
        VirtualMachineListView()
    }
}