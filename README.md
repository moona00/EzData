# EzData

Easily load and save JSON data with Swift.

## How to use:

### ContentView:
```swift
import SwiftUI

struct ContentView: View {
	@Binding var items: [MyClass]
	let saveAction: () -> void
	@Environment(\.scenePhase) private var scenePhase
	
	var body: some View {
		MyView {
			...
		}
		.onChange(of: scenePhase) { phase in
			if phase == .inactive {
				saveAction()
			}
		}
	}
}
```

### App:
```swift
import SwiftUI
import EzData

@main
struct MyApp: App {
	@ObservedObject private var data = EzData<MyClass>()
	
	var body: some Scene {
		WindowGroup {
			ContentView(items: $data.items, saveAction: data.save)
				.onAppear(perform: data.load)
		}
	}
}
```
