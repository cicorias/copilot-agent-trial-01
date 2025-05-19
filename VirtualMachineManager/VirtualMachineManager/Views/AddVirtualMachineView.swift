import SwiftUI

struct AddVirtualMachineView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var cpuCores = 1
    @State private var memoryGB = 1
    @State private var ipAddress = ""
    
    var onSave: (VirtualMachine) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("VM Details")) {
                    TextField("Name", text: $name)
                    
                    Stepper("CPU Cores: \(cpuCores)", value: $cpuCores, in: 1...16)
                    
                    Stepper("Memory (GB): \(memoryGB)", value: $memoryGB, in: 1...64)
                    
                    TextField("IP Address (Optional)", text: $ipAddress)
                }
            }
            .navigationTitle("Add Virtual Machine")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let vm = VirtualMachine(
                            name: name,
                            status: .stopped,
                            ipAddress: ipAddress.isEmpty ? nil : ipAddress,
                            cpuCores: cpuCores,
                            memoryGB: memoryGB
                        )
                        onSave(vm)
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

struct AddVirtualMachineView_Previews: PreviewProvider {
    static var previews: some View {
        AddVirtualMachineView { _ in }
    }
}