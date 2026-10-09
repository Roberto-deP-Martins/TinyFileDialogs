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

        // 1. Convert Swift filters array into C string pointers
        let filterCStrings = filters.map { _strdup($0) }
        defer { filterCStrings.forEach { free($0) } }

        let filterPointers: [UnsafePointer<CChar>?]? =
            filterCStrings.isEmpty
            ? nil
            : filterCStrings.map { UnsafePointer($0) }

        // 2. Invoke tinyfiledialogs C function
        let result = tinyfd_openFileDialog(
            title,
            defaultPath,
            Int32(filters.count),
            filterPointers,
            filterDescription.isEmpty ? nil : filterDescription,
            allowMultiple ? 1 : 0
        )

        // 3. Return Swift String or nil if user canceled
        guard let result = result else { return nil }
        return String(cString: result)
    }

    public static func saveFile(
        title: String = "Save File",
        defaultPath: String = "",
        filters: [String] = [],
        filterDescription: String = ""
    ) -> String? {

        // 1. Convert Swift filters array into C string pointers
        let filterCStrings = filters.map { _strdup($0) }
        defer { filterCStrings.forEach { free($0) } }

        let filterPointers: [UnsafePointer<CChar>?]? =
            filterCStrings.isEmpty
            ? nil
            : filterCStrings.map { UnsafePointer($0) }

        // 2. Invoke tinyfiledialogs C function
        let result = tinyfd_saveFileDialog(
            title,
            defaultPath,
            Int32(filters.count),
            filterPointers,
            filterDescription.isEmpty ? nil : filterDescription
        )

        // 3. Return Swift String or nil if user canceled
        guard let result = result else { return nil }
        return String(cString: result)
    }

    public static func selectFolder(
        title: String = "Select Folder",
        defaultPath: String = ""
    ) -> String? {
        // 1. Invoke tinyfiledialogs C function
        let result = tinyfd_selectFolderDialog(
            title,
            defaultPath
        )

        // 2. Return Swift String or nil if user canceled
        guard let result = result else { return nil }
        return String(cString: result)
    }
}