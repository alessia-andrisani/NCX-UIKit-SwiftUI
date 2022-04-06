# Notes App - How to embed an Alert with TextField in SwiftUI 


## Framework used: 
SwiftUI

## Build Info: 
- Designed for iPhone 13 Pro 
- Targets iOS 15.4
- Version 1.0
- Build 1

*** 

Unfortunately, there are still many components that only exist in `UIKit` and others that are not customizable in `SwiftUI` as much as in UIKit and the `Alert with TextField` is among them. You may be tempted to create these kinds of views custom directly in SwiftUI but you’ll soon realize that the result will never be exactly like the original and you will lose some functionalities that the native ones provide you for free. 

That's why we decided to develop `this app that lets you create notes`, give them a name (using an alert from UIKit) and also edit them. 


This simple iOS app makes use of the `UIViewControllerRepresentable` protocol to create and manage a UIKit View Controller object into a SwiftUI interface. If you want to learn more about this protocol and about an alert with TextField, read us on [Medium](https://medium.com/codex/how-to-embed-a-uikit-alert-with-text-field-in-swiftui-8547afaa1fc). 


<img width="417" alt="Screen Shot 2022-04-05 at 16 56 35" src="https://user-images.githubusercontent.com/62070103/161783155-32b50b2b-ac8f-4d69-82a2-b7d2c182830f.png">



## Structure 
- Model: 
  * `Note`: data model for the note object
  * `NotesStore`: view model with an empty array of notes 

- Views: 

  * `Content View`: the main view that displays the list of notes
  * `AddNoteView`: modal view where you create a new note
  * `NoteDetailView`: shows the details of a note previously created and let you edit it's content

- AlertWithTextField: 
  * `AlertControllerView`: creates and updates the alert with TextField from UIKit with all the functionalities


## How it works 

In the main view you can tap the plus button to create a new Note. By tapping `Done`, an alert will appear to prompt you to write a title.


![Hnet-image-2](https://user-images.githubusercontent.com/62070103/161790219-755a7af3-ca53-4b10-9c2d-07ba0e0fb334.gif)



Then, you can tap on the note to open it. Tapping the edit button will let you modify the note.

![Hnet-image-3](https://user-images.githubusercontent.com/62070103/161790758-daa2453c-047f-48ca-b881-2376bc67fa86.gif)


Finally, you can swipe from right to left on a note to delete it.


![Hnet com-image-2](https://user-images.githubusercontent.com/62070103/161792853-5a2adcbd-5fed-420c-a7aa-e5fcc1ea19b8.gif)








