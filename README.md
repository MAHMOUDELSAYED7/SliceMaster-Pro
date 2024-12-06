# SliceMaster Pro
SliceMaster Pro is a feature-rich Flutter desktop application tailored for efficient pizza shop management. Leveraging Hive for local database management and Cubit for state management, Whether handling routine operations or managing large orders, this tool offers seamless account management, pizza inventory control, secure invoice generation, and export capabilities. Designed with an intuitive, user-friendly interface, SliceMaster Pro ensures a smooth, productive experience for both shop owners and customers, enhancing operational efficiency and customer satisfaction.


## Features
- **`Account Management`**: Create accounts, securely log in, and log out with ease.
- **`Pizza Management`**: Fetch, add, remove, and update pizza entries effortlessly.
- **`Invoice Generation`**: Generate detailed invoices for each transaction, securely stored in the local database.
- **`Excel Export`**: Save all invoices to an Excel file for easy reporting and management.
- **`Intuitive Interface`**: A user-friendly interface ensures a smooth experience for both shop owners and customers.

## Screenshots
<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/ff40c9f7-1f34-4a96-8bb4-d3e496fdc471" alt="Screenshot 1" style="width: 48%;"/>
  <img src="https://github.com/user-attachments/assets/82a1ca76-75e9-4bf0-9ab2-df45886ced8f" alt="Screenshot 2" style="width: 48%;"/>
  <img src="https://github.com/user-attachments/assets/d078cf94-98e4-42e8-a0ff-a0effd7c502c" alt="Screenshot 3" style="width: 48%;"/>
  <img src="https://github.com/user-attachments/assets/71de4d4c-9d36-4aed-a742-79abda4ff76f" alt="Screenshot 4" style="width: 48%;"/>
  <img src="https://github.com/user-attachments/assets/1f0e68d1-12de-4b37-97be-94ebbedd5895" alt="Screenshot 5" style="width: 48%;"/>
  <img src="https://github.com/user-attachments/assets/00a67634-7165-4e18-884b-15019f149ad7" alt="Screenshot 6" style="width: 48%;"/>
  <img src="https://github.com/user-attachments/assets/d0b4edd8-f153-44c6-9aee-a6857a9c104a" alt="Screenshot 7" style="width: 48%;"/>
  <img src="https://github.com/user-attachments/assets/237549ab-30d6-4814-8201-c1d8903bd38e" alt="Screenshot 8" style="width: 48%;"/>
  <img src="https://github.com/user-attachments/assets/a180f534-6ad4-44f3-acb0-2118373a01b0" alt="Screenshot 9" style="width: 48%;"/>
  <img src="https://github.com/user-attachments/assets/01bbba54-7792-4361-940d-20425a137c61" alt="Screenshot 10" style="width: 22%;"/>
</div>

## Installation

To get started with SliceMaster Pro, follow these steps:

**`Step 1:`** Clone the Repository
First, you'll need to clone the repository from GitHub. Open your terminal and run the following command:
```
https://github.com/MAHMOUDELSAYED7/SliceMaster-Pro.git
```
Replace <repository-url> with the actual URL of your repository if it was changed.

**`Step 2:`** Install Dependencies
After navigating to the project directory, you need to install all the necessary dependencies. Run:
```
flutter pub get
```
This command fetches all the dependencies listed in the `pubspec.yaml` file.

**`Step 3:`** Configure the App
Ensure all necessary configurations are done. This includes adding your assets and setting up environment variables if needed. Verify that your `pubspec.yaml` file includes all required `assets` and `fonts`.

**`Step 4:`** Run the Application
Finally, run the application on your desired device using the following command:
`
```
flutter run
```
This command compiles your Flutter app and deploys it to the connected device or simulator.

Additional Tips
**`Updating Dependencies:`** If there are any updates to the dependencies, you can update them using:
```
flutter pub upgrade --major-versions
```
Flutter Doctor: Run flutter doctor to ensure that your development environment is set up correctly.
```
flutter doctor
```
This command checks your environment and displays a report of the status of your Flutter installation, dependencies, and connected devices.

By following these steps, you'll have the SliceMaster Pro desktop app and running on your device. If you encounter any issues during installation, please refer to the Flutter documentation.


## Dependencies

#### State Management:
- **`bloc`**: State management using the Bloc pattern.
- **`flutter_bloc`**: Flutter integration for the Bloc state management.

#### Database Management:
- **`hive:`**: Lightweight NoSQL database for Flutter apps.
- **`hive_flutter`**: Flutter integration for Hive database operations.

#### Excel Handling:
- **`excel`**: Create, read, and modify Excel files.

#### File Management:
- **`file_picker`**: Pick files from the device storage.
- **`path_provider`**: Access commonly used directories on the device.
- **`path`**: Manipulate file paths in a platform-independent way.

#### PDF and Printing:
- **`pdf`**: Create and manage PDF files.
- **`printing`**: Print documents and share PDFs.

#### Localization:
- **`intl`**: Handle date, time formatting, and localization.

#### UI and Icon Management:
- **`flutter_screenutil`**: Responsive UI design for multiple screen sizes.
- **`flutter_svg`**: Render SVG images in your Flutter app.
- **`shared_preferences`**: Store simple key-value pairs locally.

#### Window Management:
- **`window_manager`**: Manage and customize desktop window behavior.

#### Meta Information:
- **`meta`**: Provides annotations for Flutter code.

#### Dev Dependencies:
- **`hive_generator`**: Generates type adapters for Hive database.
- **`build_runner`**: Automates code generation tasks in Flutter.
- **`flutter_lints`**: Standard lint rules for Flutter projects.
- **`flutter_test`**: Included in Flutter SDK - Unit and widget testing framework.

## Usage

1. **`Create Account`**: Start by registering a new user account.
2. **`Login`**: Use your credentials to log into the app.
3. **`Add Pizza`**: Add new pizza options to the inventory.
4. **`Update Pizza`**: Modify the details or prices of existing pizzas.
5. **`Remove Pizza`**: Remove any outdated or unwanted pizzas.
6. **`Generate Invoice`**: Create invoices after every transaction.
7. **`View Invoice`**: Access the archive to view all stored invoices.
8. **`Save Invoices to Excel`**: Export the invoices to an Excel file for better management.
9. **`Logout`**: Safely log out when done.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For any questions or feedback, please reach out via email: [mahmoudelsayed.dev@gmail.com](mahmoudelsayed.dev@gmail.com)
