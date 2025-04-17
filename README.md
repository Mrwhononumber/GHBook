//
//  README.md
//  GHBook
//
//  Created by Basem Elkady on 4/16/25.
//

# GitHub Followers Book 📖

A clean and responsive iOS app that allows users to search GitHub profiles and explore their followers.

Built using **UIKit**, powered by the **GitHub API**, and designed to practice clean architecture, reusable components, and thoughtful UI layout using code.

---

### 📸 Screenshots

<p float="left">
  <img src="https://github.com/Mrwhononumber/Images/blob/bbc82dfd03515b24c0357e2b9001e20c12124b13/GHBook/Simulator%20Screenshot%20-%20iPhone%2016%20-%202025-04-15%20at%2011.32.29.png" width="180"/>
  <img src="https://github.com/Mrwhononumber/Images/blob/bbc82dfd03515b24c0357e2b9001e20c12124b13/GHBook/Simulator%20Screenshot%20-%20iPhone%2016%20-%202025-04-15%20at%2011.32.55.png" width="180"/>
  <img src="https://github.com/Mrwhononumber/Images/blob/bbc82dfd03515b24c0357e2b9001e20c12124b13/GHBook/Simulator%20Screenshot%20-%20iPhone%2016%20-%202025-04-15%20at%2011.33.28.png"/>
</p>

---

### 🚀 Features

- 🔍 Search for any GitHub username
- 👥 View list of followers with pagination
- 📁 Tap a follower to view their own followers
- ❤️ Add any user to your favorites list
- 🧠 Local persistence with `UserDefaults`
- 📱 Fully programmatic UI using **UIKit**
- 🖼️ Async image loading with `NSCache` support

---

### 🧩 Architecture & Tech Used

- ✅ **Architecture:** MVC with clearly separated concerns
- ✅ **UI:** Programmatic layout using Auto Layout
- ✅ **Networking:** `URLSession` with custom error handling
- ✅ **Persistence:** `UserDefaults` for saving favorites
- ✅ **Image Caching:** Lightweight in-memory cache via `NSCache`
- ✅ **Diffable Data Source:** Used for efficient `UICollectionView` updates
- ✅ **Reusable UI Components:** Custom views and base view controllers

---

### 🛠️ Future Improvements

- [ ] Migrate network layer to `async/await`
- [ ] Add unit tests to core logic and network layer
- [ ] Support dark mode UI
- [ ] Expand user profile view with more data

---

### 🧑‍💻 Author

[LinkedIn – Basem Elkady](https://www.linkedin.com/in/basemxahmed/)

                    
                    
