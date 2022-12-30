//
//  SaveError.swift
//  EzData
//
//  Created by Riccardo Terlizzi on 30/12/22.
//

import Foundation

public enum SaveError: Error {
	case fileURLNotFound
	case selfOutOfScope
	case encodingError
	case writingError
}

extension SaveError: CustomStringConvertible {
	public var description: String {
		switch self {
			case .fileURLNotFound:
				return "The Documents folder could not be found."
			case .selfOutOfScope:
				return "SaveError: self out of scope in EzData.save()."
			case .encodingError:
				return "An encoding error occurred while saving data."
			case .writingError:
				return "An error occurred while writing data."
		}
	}
}

extension SaveError: LocalizedError {
	public var errorDescription: String? {
		return "Error Saving Data"
	}
}
