import Foundation
import Combine

class VirtualMachineListViewModel: ObservableObject {
    @Published var virtualMachines: [VirtualMachine] = []
    
    init() {
        // Load sample data for demonstration
        loadSampleData()
    }
    
    private func loadSampleData() {
        virtualMachines = [
            VirtualMachine(name: "Web Server", status: .running, ipAddress: "192.168.1.10", cpuCores: 2, memoryGB: 4),
            VirtualMachine(name: "Database Server", status: .running, ipAddress: "192.168.1.11", cpuCores: 4, memoryGB: 8),
            VirtualMachine(name: "Test Machine", status: .stopped, ipAddress: "192.168.1.12", cpuCores: 1, memoryGB: 2)
        ]
    }
    
    // MARK: - VM Operations
    
    func addVirtualMachine(_ vm: VirtualMachine) {
        virtualMachines.append(vm)
    }
    
    func deleteVirtualMachine(atOffsets indexSet: IndexSet) {
        virtualMachines.remove(atOffsets: indexSet)
    }
    
    func deleteVirtualMachine(withID id: UUID) {
        if let index = virtualMachines.firstIndex(where: { $0.id == id }) {
            virtualMachines.remove(at: index)
        }
    }
    
    func startVirtualMachine(withID id: UUID) {
        if let index = virtualMachines.firstIndex(where: { $0.id == id }) {
            virtualMachines[index].status = .running
        }
    }
    
    func stopVirtualMachine(withID id: UUID) {
        if let index = virtualMachines.firstIndex(where: { $0.id == id }) {
            virtualMachines[index].status = .stopped
        }
    }
}