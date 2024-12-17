## How to execute our app:
1. The first step would be to download, and extract the zip file of our repo.
2. Once installed, start a new terminal and ensure you are in “\indulge”.
3. Then run these commands based on your device:
  - macOS (recommended):
    - Start the iOS Simulator (follow docs on Canvas if not setup)
    - flutter pub get
    - flutter run
    - iOS Simulator should be automatically selected, but select it from devices list if not.
  - Windows:
    - flutter pub get
    - flutter run
    - *Wait until prompted to select device*
    - Select either Chrome or Windows, but the app may not work correctly or may look different in
these formats

## IMPORTANT NOTES
### User Creation
- There are no users created when first starting the app. Follow the onboarding process to create a new user (create new account).
- Our app is designed for **one** user only. Please create your user with the following username and password. Email and any other information does not matter:
- username: user
- password: pass

### Working with the Database
If you experience any issues with the database upon first load, please follow these instructions:
1. Find the DB path being printed out in the terminal:
```bash
flutter: DB PATH, changes with simulator restarts:
/Users/snwilson/Library/Developer/CoreSimulator/Devices/203AAABA-A55E-46C7-8E35-7A8148048FD1/data/Containers/Data/Application/8592E8BF-F911-486C-A56D-24B9EEC9A06C/Documents/indulge.db
```
2. Copy this path ending at /Documents/ (.../Documents/)
3. Open a terminal and cd to this Documents folder
```bash
cd /Users/..FULL_PATH../Documents/
```
4. Use the following command to remove the database
```bash
rm indulge.db
```

5. Go to the terminal where you are running Flutter and perform two Hot Restarts with Ctrl/Cmd + Shift + R. The first one will print a Disk i/o error and the second one will recreate the DB correctly.

