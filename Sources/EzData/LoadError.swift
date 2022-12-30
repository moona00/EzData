//
//  LoadError.swift
//  EzData
//
//  Created by Riccardo Terlizzi on 30/12/22.
//

import Foundation

public enum LoadError: Error {
	case fileURLNotFound
	case decodingError
}

extension LoadError: CustomStringConvertible {
	public var description: String {
		switch self {
			case .fileURLNotFound:
				return "The Documents folder could not be found."
			case .decodingError:
				return "An error occurred while decoding saved data."
		}
	}
}

extension LoadError: LocalizedError {
	public var errorDescription: String? {
		return "Error Loading Data"
	}
}
