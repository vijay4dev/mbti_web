# MBTI Analysis Web App

A beautiful Flutter web application that integrates with your n8n automation to analyze MBTI personality types based on usernames.

## Features

- 🎨 Modern, responsive UI with gradient backgrounds
- 🔗 Integration with n8n webhook at `https://vijayy.app.n8n.cloud/webhook-test/mbti-analysis`
- 📱 Mobile-friendly design
- ⚡ Real-time loading states and error handling
- 🎯 Clean, intuitive user experience

## How to Use

1. **Enter a username** in the input field (e.g., "brrocode")
2. **Click "Analyze My Personality"** to send the request to your n8n webhook
3. **View the MBTI analysis result** displayed in a beautiful card format
4. **Analyze another username** by clicking the button after getting results

## Technical Details

- **Framework**: Flutter Web
- **Architecture**: Clean architecture with separated concerns
- **HTTP Client**: Uses the `http` package for API calls
- **Styling**: Google Fonts (Inter) for typography
- **Design**: Material Design 3 with custom gradients and animations

## Project Structure
```
mbti_web/
├── lib/
│   ├── main.dart                    # Main application entry point
│   ├── models/
│   │   └── mbti_analysis.dart      # Data models for MBTI analysis
│   ├── services/
│   │   └── mbti_service.dart       # API service for n8n webhook
│   └── widgets/
│       ├── app_header.dart         # Header component
│       ├── app_footer.dart         # Footer component
│       ├── mbti_input_form.dart    # Username input form
│       └── mbti_result_card.dart   # MBTI analysis result display
├── pubspec.yaml                    # Dependencies (http, google_fonts)
├── README.md                      # Documentation
└── web/                           # Web-specific files
```

## Architecture

The application follows a clean architecture pattern with separated concerns:

- **Models**: Data classes for MBTI analysis structure (`MBTIAnalysis`, `MBTIAnalyses`)
- **Services**: API communication logic (`MBTIService`)
- **Widgets**: Reusable UI components (forms, cards, headers)
- **Main**: Application state management and navigation

## API Integration

The app sends a POST request to your n8n webhook with the following structure:

```json
{
  "username": "brrocode"
}
```

The webhook should respond with the MBTI analysis result, which will be displayed to the user.

## Running the Application

1. **Install Flutter** (if not already installed)
2. **Navigate to the project directory**:
   ```bash
   cd mbti_web
   ```
3. **Get dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the web app**:
   ```bash
   flutter run -d chrome
   ```

## Customization

- **Colors**: Modify the gradient colors in the respective widget files
- **Fonts**: Change the Google Fonts import in `main.dart`
- **API Endpoint**: Update the webhook URL in `services/mbti_service.dart`
- **UI Elements**: Customize individual widget components as needed
- **Data Models**: Modify `models/mbti_analysis.dart` if the API response structure changes

## Deployment

To deploy this Flutter web app:

1. **Build for web**:
   ```bash
   flutter build web
   ```
2. **Deploy the `build/web` folder** to any web hosting service (Netlify, Vercel, Firebase Hosting, etc.)

## Requirements

- Flutter SDK (latest stable version)
- Chrome browser for development
- Internet connection for Google Fonts and API calls