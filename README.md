# EzData

Easily load and save JSON data with Swift.

## How to use:

### Model
```swift
class MyModel: Codable {
	...
}

#if DEBUG
extension MyModel {
	// Make an example array to use in previews
	static var exampleItems = [...]
}
#endif
```

### ContentView:
```swift
import SwiftUI

struct ContentView: View {
	@Binding var items: [MyModel]
	let saveAction: () -> Void
	
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

struct ContentView_Previews: PreviewProvider {
	@State private static var items = MyModel.exampleItems
	
	static var previews: some View {
		ContentView(items: $items, saveAction: {})
	}
}
```

### App:
```swift
import SwiftUI
import EzData

@main
struct MyApp: App {
	@ObservedObject private var data = EzData<MyModel>()
	
	var body: some Scene {
		WindowGroup {
			ContentView(items: $data.items, saveAction: data.save)
				.onAppear(perform: data.load)
		}
	}
}
```
