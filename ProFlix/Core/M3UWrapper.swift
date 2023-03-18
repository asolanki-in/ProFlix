//
//  M3UWrapper.swift
//  ProFlix
//
//  Created by Anil Solanki on 18/03/23.
//

import Foundation
import M3UKit

struct M3UWrapper {
	public func parse(m3uStr: String) throws -> Playlist? {
		let parser = PlaylistParser()
		if let url = URL(string: m3uStr) {
			return try parser.parse(url)
		}
		return nil
	}
}
