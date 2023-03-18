//
//  ProFlixApp.swift
//  ProFlix
//
//  Created by Anil Solanki on 19/02/23.
//

import SwiftUI

@main
struct ProFlixApp: App {
	@StateObject var coreData = CoreDataEnvironmentObject()

    var body: some Scene {
        WindowGroup {
			ProFlixRootView().environmentObject(coreData)
        }
    }
}
