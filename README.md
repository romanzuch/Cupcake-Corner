#  Cupcake Corner

## Idea

- this project will look deeper into `Codable`
- there are four main topics in this project in which we will learn
    - custom `Codable` implementations
    - `URLSession`
    - `disabled()` modifier and more

## Introduction

- this project will be a multi-screen app for ordering cupcakes
- we will make classes conform to `Codable` when they have `@Published` properties
- we will see how to send and receive the order data from the internet
- we will see how to validate forms, and more...

## Adding Codable conformance for `@Published` properties

- when all properties of a type conform to `Codable` &rarr; the type itself also conforms 
- however, this doesn't work when using property wrappers such as `@Published`
```Swift
class User: ObservableObject, Codable {
    @Published var name = "Paul Hudson"
}
```
- the name property wrapper comes from the property being wrapped inside another type that adds some additional functionality
- contraire to `Sets`, `Arrays`, and `Dictionaries`, Swift doesn't provide `Published` with the functionality, that whenever the contents conform to `Codable`, then also the wrapper conforms to it
- first we need to tell Swift which properties should be loaded and saved &rarr; add the following to the `User` class
```Swift
enum CodingKeys: CodingKey {
    case name
}
```
- in the next step we need to create a custom initializer &rarr; add the following to the `User` class
```Swift
required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(String.self, forKey: .name)
}
```
- the above holds at least four new things:
    1. the initializer is handed an instance of a new type &rarr; `Decoder`, which holds all our data
    2. anyone who subclasses our `User` class must override this initializer with a custom implementation &rarr; marked by the `required` keyword (to forbid subclassing, use `final` keyword with `class`)
    3. `decoder.container(keyedBy: CodingKeys.self)` &rarr; "this data should have a container where the keys match whatever cases we have in our `CodingKeys` enum"
    4. we can read values directly from that container &rarr; `container.decode(String.self, forKey: .name)` 
- to make our class conform to `Codable` we need to tell Swift how to encode this type
```Swift
func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
}
```
- all of the above combined into one class will now compile
```Swift
class User: ObservableObject, Codable {
    @Published var name = "Paul Hudson"
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
}
```

## Sending and receiving `Codable` data with `URLSession` and SwiftUI

- iOS gives built-in tools for sending and receiving data from the internet &rarr; combined with `Codable` this gives the power to convert Swift objects to JSON for sending, and receiving JSON to be converted to Swift objects
```Swift
struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}
```
- with the above we can write a simple `ContentView` that shows an array of results &rarr; that won't work right now
```Swift
struct ContentView: View {
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
    }
}
```
- now we need to ask the iTunes API to send us a list of all songs of a particular artist, then use the `JSONDecoder` to convert it into an array of `Result` instances
- we want this to happen as soon as our `List` is shown &rarr; add `.onAppear(perform: loadData)` modifier to list
- inside `loadData()` we have four steps we need to complete:
    1. Create the URL we want to read.
    2. Wrapping it into a `URLRequest` &rarr; allows us to configure how the URL should be accessed.
    3. Create and start a networking task from that URL request.
    4. Handle the result.
```Swift
func loadData() {
    guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
        print("Invalid URL")
        return
    }
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data {
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                // there is good data -> go back to main thread
                DispatchQueue.main.async {
                    self.results = decodedResponse.results
                }
                
                return
            }
        }
        
        print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
    }.resume()
}
```
