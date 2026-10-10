import Foundation
import CTinyFileDialogs

public struct FilePicker {
    /// - Parameters:
    ///   - title: Window title.
    ///   - defaultPath: Initial directory or file path.
    ///   - filters: List of allowed wildcard patterns (e.g., ["*.txt", "*.png"]).
    ///   - filterDescription: Description for allowed file types (optional).
    ///   - allowMultiple: Allow selecting multiple files.
    /// - Returns: File path string (or comma-separated paths if multiple selected), or nil if cancelled.
    public static func openFile(
        title: String = "Select File",
        defaultPath: String = "",
        filters: [String] = [],
        filterDescription: String = "",
        allowMultiple: Bool = false
    ) -> String? {

        return withCStringArray(filters) { filterPointers in
            let result = tinyfd_openFileDialog(
                title,
                defaultPath,
                Int32(filters.count),
                filterPointers,
                filterDescription.isEmpty ? nil : filterDescription,
                allowMultiple ? 1 : 0
            )
            guard let result = result else { return nil }
            return String(cString: result)
        }
    }

    public static func saveFile(
        title: String = "Save File",
        defaultPath: String = "",
        filters: [String] = [],
        filterDescription: String = ""
    ) -> String? {

        return withCStringArray(filters) { filterPointers in
            let result = tinyfd_saveFileDialog(
                title,
                defaultPath,
                Int32(filters.count),
                filterPointers,
                filterDescription.isEmpty ? nil : filterDescription
            )
            guard let result = result else { return nil }
            return String(cString: result)
        }
    }

    public static func selectFolder(
        title: String = "Select Folder",
        defaultPath: String = ""
    ) -> String? {
        let result = tinyfd_selectFolderDialog(
            title,
            defaultPath
        )

        guard let result = result else { return nil }
        return String(cString: result)
    }

    private static func withCStringArray(_ strings: [String], _ functionBody: ([UnsafePointer<CChar>?]?) -> String?) -> String? {
        guard !strings.isEmpty else { return functionBody(nil) }
        
        func addToArray(_ index: Int, _ accumulatedArray: [UnsafePointer<CChar>?]) -> String? {
            if index == strings.count {
                return functionBody(accumulatedArray)
            }
            return strings[index].withCString { cString in
                addToArray(index + 1, accumulatedArray + [cString])
            }
        }
        
        return addToArray(0, [])
    }
}