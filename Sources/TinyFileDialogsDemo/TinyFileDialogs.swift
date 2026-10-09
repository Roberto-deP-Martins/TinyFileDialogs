import Foundation
import TinyFileDialogs

@main
struct TinyFileDialogs {
    static func main() {
        let arguments = CommandLine.arguments
        switch arguments[1] {
        case "--open-file":
            _ = FilePicker.openFile()
            break
        case "--save-file":
            _ = FilePicker.saveFile()
            break
        case "--select-folder":
            _ = FilePicker.selectFolder()
            break
        default:
            print("Usage: \(arguments[0]) [--open-file|--save-file|--select-folder]")
        }
    }
}