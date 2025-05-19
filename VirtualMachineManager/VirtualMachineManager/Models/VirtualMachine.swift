import Foundation

struct VirtualMachine: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var status: VMStatus
    var ipAddress: String?
    var cpuCores: Int
    var memoryGB: Int
    
    enum VMStatus: String, CaseIterable {
        case running = "Running"
        case stopped = "Stopped"
        case paused = "Paused"
        
        var isRunning: Bool {
            return self == .running
        }
    }
    
    static func == (lhs: VirtualMachine, rhs: VirtualMachine) -> Bool {
        return lhs.id == rhs.id
    }
}