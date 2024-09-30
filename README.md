Motivational Quotes & Weather Screen Saver AppThis SwiftUI app displays motivational quotes and weather information on a screen saver. It also provides hourly reminders to help you stay positive and productive throughout the day.
Features- Motivational Quotes: Displays quotes in both Chinese and English.
- Weather Information: Shows current weather conditions.
- Hourly Reminders: Provides helpful reminders based on the time of day.
- Smooth Animations: Uses SwiftUI animations for a visually appealing experience.
Getting StartedPrerequisites- Xcode 12 or later
- iOS 14.0 or later
Installation- Clone the repository:

git clone https://github.com/ruv2005/screensaver.git

- Open the project in Xcode:

cd screensaver
open screensaver.xcodeproj

- Build and run the app on your simulator or device.
Usage- The app will automatically fetch and display a new motivational quote every 10 seconds.
- The current date, time, and day of the week are displayed at the top.
- Hourly reminders are shown based on the current time.
Code OverviewContentView.swift- State Variables: Manages the state for quotes, reminders, time, and date.
- Body: Defines the main UI layout using SwiftUI views.
- Functions:
    - startTimer(): Starts a timer to fetch new quotes periodically.
    - stopTimer(): Stops the timer.
    - fetchyiyan(): Fetches quotes from an API.
    - updateTimeAndDate(): Updates the current time and date.
    - updateReminder(): Updates the reminder message based on the current hour.
    - formatyiyan(): Formats the quotes for better readability.
yiyanResponse.swift- yiyanResponse: A Codable struct to parse the JSON response from the quotes API.
Contributing- Fork the repository.
- Create your feature branch:

git checkout -b feature/YourFeature

- Commit your changes:

git commit -m 'Add some feature'

- Push to the branch:

git push origin feature/YourFeature

- Open a pull request.
  LicenseThis project is licensed under the MIT License - see the LICENSE file for details.
Acknowledgments- KAPI API for providing motivational quotes.
Feel free to customize this README to better fit your project's specifics! If you have any other questions or need further assistance, just let me know.
