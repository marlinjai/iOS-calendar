
# iOS Calendar App

This project is an iOS calendar application implemented using the MVC (Model-View-Controller) pattern for our ios development course @HTW Berlin. The application allows users to manage contacts with detailed information, including personal details, hobbies, and friends. 

## Features

- Add, update, and delete contacts.
- Manage personal details of each contact.
- Add and remove hobbies for each contact.
- Select and manage friends for each contact.
- Persistent storage of contacts using JSON.

## Project Structure

- **Model**: Contains the data and business logic.
  - `Hobby`: Represents a hobby associated with a contact.
  - `AddressCard`: Represents a contact with personal details, hobbies, and friends.
  - `AddressBook`: Manages a collection of contacts and provides methods for searching, updating, and persisting data.
  
- **Views**: Contains the user interface components.
  - `ContentView`: The main view displaying the list of contacts.
  - `DetailView`: Displays and allows editing of a contact's details.
  - `AddContactView`: Form for adding a new contact.
  - `FriendsSelectionView`: Interface for selecting friends for a contact.
  - `NewContactFriendsSelectionView`: Interface for selecting friends when creating a new contact.

- **ViewModel**: Acts as a bridge between the Model and Views, handling the presentation logic.
  - `ViewModel`: Manages the state of the address book and provides methods for interacting with the data.

## Setup Instructions

1. **Clone the repository:**
   ```sh
   git clone https://github.com/yourusername/iOSCalendarApp.git
   cd iOSCalendarApp
   ```

2. **Open the project in Xcode:**
   Open `iOS5_Pohl.xcodeproj` in Xcode.

3. **Build and run the project:**
   Select a target device or simulator and click the "Run" button in Xcode.

## Code Overview

### iOS5_PohlApp.swift

The main entry point of the application. It initializes the `ViewModel` and sets up the `ContentView`.

```swift
@main
struct iOS5_PohlApp: App {
    @Environment(\.scenePhase) private var scenePhase
    var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .onChange(of: scenePhase) { newScenePhase in
                    switch newScenePhase {
                    case .inactive:
                        viewModel.saveAddressBook()
                    default:
                        break
                    }
                }
        }
    }
}
```

### Model

#### Hobby.swift

Defines a hobby and implements the necessary protocols for identification and serialization.

```swift
class Hobby: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
    
    static func == (left: Hobby, right: Hobby) -> Bool {
        return left.id == right.id
    }
}
```

#### AddressCard.swift

Defines a contact card with personal details, hobbies, and friends.

```swift
class AddressCard: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    var vorname: String
    var nachname: String
    var straße: String
    var plz: Int
    var ort: String
    var hobbies: [Hobby]
    var freunde: [AddressCard.ID]
   
    // Initialization and methods...
}
```

#### AddressBook.swift

Manages a collection of `AddressCard` and provides methods for adding, removing, and searching contacts.

```swift
class AddressBook: Codable {
    var addressBook = [AddressCard]()
    
    init() {
        // Initialize with default data...
    }
    
    // Methods for adding, removing, searching, and persisting contacts...
}
```

### Views

#### ContentView.swift

The main view displaying the list of contacts.

```swift
struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    // List of contacts...
                }
                .toolbar {
                    // Toolbar content...
                }
            }
            .navigationTitle("Contacts")
        }.searchable(text: $searchText, prompt: "find a contact")
    }
}
```

#### DetailView.swift

Displays and allows editing of a contact's details.

```swift
struct DetailView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var addressCard: AddressCard
    @Environment(\.editMode) var editMode
    
    var body: some View {
        List {
            // Sections for personal details, hobbies, and friends...
        }
        .navigationTitle("\(addressCard.vorname) \(addressCard.nachname)")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
}
```

#### AddContactView.swift

Form for adding a new contact.

```swift
struct AddContactView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var vorname: String = ""
    @State private var nachname: String = ""
    @State private var straße: String = ""
    @State private var plz: String = ""
    @State private var ort: String = ""
    @State private var newHobby: String = ""
    @State private var hobbies: [Hobby] = []
    @State private var selectedFriends: Set<UUID> = []
    
    var body: some View {
        NavigationView {
            Form {
                // Sections for required data, hobbies, and friends...
                Button("Add Contact") {
                    // Add contact action...
                }
            }
            .navigationBarTitle("Add New Contact", displayMode: .inline)
        }
    }
}
```

### ViewModel

Handles the interaction between the model and the views.

```swift
class ViewModel: ObservableObject {
    @Published private var model: AddressBook
    
    init() {
        if let loadedAddressBook = AddressBook.addressBook(fromFile: "mybook.json") {
            model = loadedAddressBook
        } else {
            model = AddressBook()
        }
    }
    
    var addressBook: [AddressCard] {
        get { model.addressBook }
        set { model.addressBook = newValue }
    }
    
    // Methods for adding, updating, and removing contacts, hobbies, and friends...
}
```

## License

This project is licensed under the MIT License.

---
