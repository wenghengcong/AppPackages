//
//  Operators.swift
//  FileKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015-2017 Nikolai Vazquez
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

// swiftlint:disable file_length

import Foundation

private func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// MARK: - File

/// Returns `true` if both files' paths are the same.

public func ==<DataType>(lhs: File<DataType>, rhs: File<DataType>) -> Bool {
    return lhs.path == rhs.path
}

/// Returns `true` if `lhs` is smaller than `rhs` in size.

public func < <DataType>(lhs: File<DataType>, rhs: File<DataType>) -> Bool {
    return lhs.size < rhs.size
}

infix operator |>

/// Writes data to a file.
///
/// - Throws: `FileKitError.WriteToFileFail`
///
public func |> <DataType>(data: DataType, file: File<DataType>) throws {
    try file.write(data)
}

// MARK: - TextFile

/// Returns `true` if both text files have the same path and encoding.

public func == (lhs: TextFile, rhs: TextFile) -> Bool {
    return lhs.path == rhs.path && lhs.encoding == rhs.encoding
}

infix operator |>>

/// Appends a string to a text file.
///
/// If the text file can't be read from, such in the case that it doesn't exist,
/// then it will try to write the data directly to the file.
///
/// - Throws: `FileKitError.WriteToFileFail`
///
public func |>> (data: String, file: TextFile) throws {
    let textStreamWriter = try file.streamWriter(append: true)

    guard textStreamWriter.writeDelimiter(), textStreamWriter.write(line: data, delim: false) else {
        let reason: FileKitError.ReasonError
        if textStreamWriter.isClosed {
            reason = .closed
        } else {
            reason = .encoding(textStreamWriter.encoding, data: data)
        }
        throw FileKitError.writeToFileFail(path: file.path, error: reason)
    }
}

/// Return lines of file that match the motif.

public func | (file: TextFile, motif: String) -> [String] {
    return file.grep(motif)
}

infix operator |-
/// Return lines of file that does'nt match the motif.

public func |- (file: TextFile, motif: String) -> [String] {
    return file.grep(motif, include: false)
}

infix operator |~
/// Return lines of file that match the regex motif.

public func |~ (file: TextFile, motif: String) -> [String] {
    return file.grep(motif, options: .regularExpression)
}

// MARK: - FileKitPath

/// Returns `true` if the standardized form of one path equals that of another
/// path.

public func == (lhs: FileKitPath, rhs: FileKitPath) -> Bool {
    if lhs.isAbsolute || rhs.isAbsolute {
        return lhs.absolute.rawValue == rhs.absolute.rawValue
    }
    return lhs.standardRawValueWithTilde == rhs.standardRawValueWithTilde
}

/// Returns `true` if the standardized form of one path not equals that of another
/// path.

public func != (lhs: FileKitPath, rhs: FileKitPath) -> Bool {
    return !(lhs == rhs)
}

/// Concatenates two `FileKitPath` instances and returns the result.
///
/// ```swift
/// let systemLibrary: FileKitPath = "/System/Library"
/// print(systemLib + "Fonts")  // "/System/Library/Fonts"
/// ```
///

public func + (lhs: FileKitPath, rhs: FileKitPath) -> FileKitPath {
    if lhs.rawValue.isEmpty || lhs.rawValue == "." { return rhs }
    if rhs.rawValue.isEmpty || rhs.rawValue == "." { return lhs }
    switch (lhs.rawValue.hasSuffix(FileKitPath.separator), rhs.rawValue.hasPrefix(FileKitPath.separator)) {
    case (true, true):
        let rhsRawValue = rhs.dropFirst()
        return FileKitPath("\(lhs.rawValue)\(rhsRawValue)")
    case (false, false):
        return FileKitPath("\(lhs.rawValue)\(FileKitPath.separator)\(rhs.rawValue)")
    default:
        return FileKitPath("\(lhs.rawValue)\(rhs.rawValue)")
    }
}

/// Converts a `String` to a `FileKitPath` and returns the concatenated result.

public func + (lhs: String, rhs: FileKitPath) -> FileKitPath {
    return FileKitPath(lhs) + rhs
}

/// Converts a `String` to a `FileKitPath` and returns the concatenated result.

public func + (lhs: FileKitPath, rhs: String) -> FileKitPath {
    return lhs + FileKitPath(rhs)
}

/// Appends the right path to the left path.
public func += (lhs: inout FileKitPath, rhs: FileKitPath) {
    // swiftlint:disable:next shorthand_operator
    lhs = lhs + rhs
}

/// Appends the path value of the String to the left path.
public func += (lhs: inout FileKitPath, rhs: String) {
    // swiftlint:disable:next shorthand_operator
    lhs = lhs + rhs
}

/// Concatenates two `FileKitPath` instances and returns the result.

public func / (lhs: FileKitPath, rhs: FileKitPath) -> FileKitPath {
    return lhs + rhs
}

/// Converts a `String` to a `FileKitPath` and returns the concatenated result.

public func / (lhs: FileKitPath, rhs: String) -> FileKitPath {
    return lhs + rhs
}

/// Converts a `String` to a `FileKitPath` and returns the concatenated result.

public func / (lhs: String, rhs: FileKitPath) -> FileKitPath {
    return lhs + rhs
}

/// Appends the right path to the left path.
public func /= (lhs: inout FileKitPath, rhs: FileKitPath) {
    lhs += rhs
}

/// Appends the path value of the String to the left path.
public func /= (lhs: inout FileKitPath, rhs: String) {
    lhs += rhs
}

precedencegroup FileCommonAncestorPrecedence {
    associativity: left
}

infix operator <^> : FileCommonAncestorPrecedence

/// Returns the common ancestor between the two paths.

public func <^> (lhs: FileKitPath, rhs: FileKitPath) -> FileKitPath {
    return lhs.commonAncestor(rhs)
}

infix operator </>

/// Runs `closure` with the path as its current working directory.
public func </> (path: FileKitPath, closure: () throws -> Void) rethrows {
    try path.changeDirectory(closure)
}

infix operator ->>

/// Moves the file at the left path to a path.
///
/// Throws an error if the file at the left path could not be moved or if a file
/// already exists at the right path.
///
/// - Throws: `FileKitError.FileDoesNotExist`, `FileKitError.MoveFileFail`
///
public func ->> (lhs: FileKitPath, rhs: FileKitPath) throws {
    try lhs.moveFile(to: rhs)
}

/// Moves a file to a path.
///
/// Throws an error if the file could not be moved or if a file already
/// exists at the destination path.
///
/// - Throws: `FileKitError.FileDoesNotExist`, `FileKitError.MoveFileFail`
///
public func ->> <DataType>(lhs: File<DataType>, rhs: FileKitPath) throws {
    try lhs.move(to: rhs)
}

infix operator ->!

/// Forcibly moves the file at the left path to the right path.
///
/// - Warning: If a file at the right path already exists, it will be deleted.
///
/// - Throws:
///     `FileKitError.DeleteFileFail`,
///     `FileKitError.FileDoesNotExist`,
///     `FileKitError.CreateSymlinkFail`
///
public func ->! (lhs: FileKitPath, rhs: FileKitPath) throws {
    if rhs.isAny {
        try rhs.deleteFile()
    }
    try lhs ->> rhs
}

/// Forcibly moves a file to a path.
///
/// - Warning: If a file at the right path already exists, it will be deleted.
///
/// - Throws:
///     `FileKitError.DeleteFileFail`,
///     `FileKitError.FileDoesNotExist`,
///     `FileKitError.CreateSymlinkFail`
///
public func ->! <DataType>(lhs: File<DataType>, rhs: FileKitPath) throws {
    if rhs.isAny {
        try rhs.deleteFile()
    }
    try lhs ->> rhs
}

infix operator +>>

/// Copies the file at the left path to the right path.
///
/// Throws an error if the file at the left path could not be copied or if a file
/// already exists at the right path.
///
/// - Throws: `FileKitError.FileDoesNotExist`, `FileKitError.CopyFileFail`
///
public func +>> (lhs: FileKitPath, rhs: FileKitPath) throws {
    try lhs.copyFile(to: rhs)
}

/// Copies a file to a path.
///
/// Throws an error if the file could not be copied or if a file already
/// exists at the destination path.
///
/// - Throws: `FileKitError.FileDoesNotExist`, `FileKitError.CopyFileFail`
///
public func +>> <DataType>(lhs: File<DataType>, rhs: FileKitPath) throws {
    try lhs.copy(to: rhs)
}

infix operator +>!

/// Forcibly copies the file at the left path to the right path.
///
/// - Warning: If a file at the right path already exists, it will be deleted.
///
/// - Throws:
///     `FileKitError.DeleteFileFail`,
///     `FileKitError.FileDoesNotExist`,
///     `FileKitError.CreateSymlinkFail`
///
public func +>! (lhs: FileKitPath, rhs: FileKitPath) throws {
    if rhs.isAny {
        try rhs.deleteFile()
    }
    try lhs +>> rhs
}

/// Forcibly copies a file to a path.
///
/// - Warning: If a file at the right path already exists, it will be deleted.
///
/// - Throws:
///     `FileKitError.DeleteFileFail`,
///     `FileKitError.FileDoesNotExist`,
///     `FileKitError.CreateSymlinkFail`
///
public func +>! <DataType>(lhs: File<DataType>, rhs: FileKitPath) throws {
    if rhs.isAny {
        try rhs.deleteFile()
    }
    try lhs +>> rhs
}

infix operator =>>

/// Creates a symlink of the left path at the right path.
///
/// If the symbolic link path already exists and _is not_ a directory, an
/// error will be thrown and a link will not be created.
///
/// If the symbolic link path already exists and _is_ a directory, the link
/// will be made to a file in that directory.
///
/// - Throws:
///     `FileKitError.FileDoesNotExist`,
///     `FileKitError.CreateSymlinkFail`
///
public func =>> (lhs: FileKitPath, rhs: FileKitPath) throws {
    try lhs.symlinkFile(to: rhs)
}

/// Symlinks a file to a path.
///
/// If the path already exists and _is not_ a directory, an error will be
/// thrown and a link will not be created.
///
/// If the path already exists and _is_ a directory, the link will be made
/// to the file in that directory.
///
/// - Throws: `FileKitError.FileDoesNotExist`, `FileKitError.CreateSymlinkFail`
///
public func =>> <DataType>(lhs: File<DataType>, rhs: FileKitPath) throws {
    try lhs.symlink(to: rhs)
}

infix operator =>!

/// Forcibly creates a symlink of the left path at the right path by deleting
/// anything at the right path before creating the symlink.
///
/// - Warning: If the symbolic link path already exists, it will be deleted.
///
/// - Throws:
///     `FileKitError.DeleteFileFail`,
///     `FileKitError.FileDoesNotExist`,
///     `FileKitError.CreateSymlinkFail`
///
public func =>! (lhs: FileKitPath, rhs: FileKitPath) throws {
    //    guard lhs.exists else {
    //        throw FileKitError.FileDoesNotExist(path: lhs)
    //    }

    let linkPath = rhs.isDirectory ? rhs + lhs.fileName : rhs
    if linkPath.isAny { try linkPath.deleteFile() }

    try lhs =>> rhs
}

/// Forcibly creates a symlink of a file at a path by deleting anything at the
/// path before creating the symlink.
///
/// - Warning: If the path already exists, it will be deleted.
///
/// - Throws:
///     `FileKitError.DeleteFileFail`,
///     `FileKitError.FileDoesNotExist`,
///     `FileKitError.CreateSymlinkFail`
///
public func =>! <DataType>(lhs: File<DataType>, rhs: FileKitPath) throws {
    try lhs.path =>! rhs
}

postfix operator %

/// Returns the standardized version of the path.

public postfix func % (path: FileKitPath) -> FileKitPath {
    return path.standardized
}

postfix operator *

/// Returns the resolved version of the path.

public postfix func * (path: FileKitPath) -> FileKitPath {
    return path.resolved
}

postfix operator ^

/// Returns the path's parent path.

public postfix func ^ (path: FileKitPath) -> FileKitPath {
    return path.parent
}
