//
//  Data.swift
//  EzData
//
//  Created by Riccardo Terlizzi on 29/12/22.
//

import Foundation

@available(macOS 10.15, *)
public class EzData<T: Codable>: ObservableObject {
	private static var documentsFolder: URL? {
		do {
			return try FileManager.default.url(
				for: .documentDirectory,
				in: .userDomainMask,
				appropriateFor: nil,
				create: false
			)
		} catch {
			return nil
		}
	}
	
	private static var fileURL: URL? {
		return documentsFolder?.appendingPathComponent("items.data") ?? nil
	}
	
	@Published var items: [T] = []
	
	func load() throws {
		if Self.fileURL == nil {
			throw LoadError.fileURLNotFound
		}
		
		var failed = false
		
		DispatchQueue.global(qos: .background).async { [weak self] in
			guard let data = try? Data(contentsOf: Self.fileURL!) else {
				return
			}
			
			guard let itemsData = try? JSONDecoder().decode([T].self, from: data) else {
				failed = true
				return
			}
			
			DispatchQueue.main.async { self?.items = itemsData }
		}
		
		if failed {
			throw LoadError.decodingError
		}
	}
	
	func save() throws {
		if Self.fileURL == nil {
			throw SaveError.fileURLNotFound
		}
		
		var err: Error?
		
		DispatchQueue.global(qos: .background).async { [weak self] in
			guard let items = self?.items else {
				err = SaveError.selfOutOfScope
				return
			}
			
			guard let data = try? JSONEncoder().encode(items) else {
				err = SaveError.encodingError
				return
			}
			
			do {
				try data.write(to: Self.fileURL!)
			} catch {
				err = SaveError.writingError
			}
		}
		
		if err != nil {
			throw err!
		}
	}
}
