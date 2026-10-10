import Foundation
import TinyFileDialogs

@main
struct TinyFileDialogs {
    static func main() {
        let arguments = CommandLine.arguments
        switch arguments[1] {
        case "--open-file":
            if let path =  FilePicker.openFile() {
                print("Selected path: \(path)")
            } else {
                print("No file selected.")
            }
            break
        case "--save-file":
            if let path =  FilePicker.saveFile() {
                print("Selected path: \(path)")
            } else {
                print("No file selected.")
            }
            break
        case "--select-folder":
            if let path =  FilePicker.selectFolder() {
                print("Selected path: \(path)")
            } else {
                print("No folder selected.")
            }
            break
        default:
            print("Usage: \(arguments[0]) [--open-file|--save-file|--select-folder]")
        }
    }
}