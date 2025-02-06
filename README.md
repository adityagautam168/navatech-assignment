# Album Gallery Demo
- This is a demo project for an album gallery app. 
- The home screen contains a vertical list of albums, where each album is associated with a list of horizontally scrollable photos

## Features
- Infinitely scrollable album lists in both vertical directions
- Infinitely scrollable photo lists in both horizontal directions
- Uses local database caching (using [sqflite](https://pub.dev/packages/sqflite)) to store album and photo data
- Images caching using [cached_network_image](https://pub.dev/packages/cached_network_image)

## Architecture
- MVVM architecture with well defined layers (data, domain, presentation)  
- State management framework using the [Bloc](https://pub.dev/packages/flutter_bloc) library
- Dependency injection using [flutter_simple_dependency_injection](https://pub.dev/packages/flutter_simple_dependency_injection)
- Network calls using [http](https://pub.dev/packages/http) package
- Data model JSON serialization using [json_serializable](https://pub.dev/packages/json_serializable), [json_annotation](https://pub.dev/packages/json_annotation) and [build_runner](https://pub.dev/packages/build_runner) packages

### Scope for improvement
- Paginated loading of album and photo lists
- Unit testing