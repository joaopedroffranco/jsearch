# FindMatch

Package which holds the FindMatch code.

The `Filters` and `Kaart` screen are using `JWIP` view. Both are wrapped into `UIHostingController`.

It also contains the main flow: `Shifts`. Showing the current jobs available for the user.

It contains the views, view models, and the router delegate related to the FindMatch scope.

### Views

- ShiftsScreen: The main screen for this flow is in SwiftUI. It assembles the other views to build the final screen.
  - States: there are 4 possible states relying on its content. Each state has its own view.
- ShiftListView: The view listing the shifts. It is basically the table view, also in SwiftUI. It uses the JUI views, like `JTile`.
- AuthenticationEntryPointView: It is the bottom view to go to whether to log in or sign up, using the `JButton`s.
- ShiftsViewController: Wrapps the `ShiftsScren` into a `UIHostingController`.

### ViewModel

The layer is responsible to get the models and make them fittable for views.

- ShiftsScreenViewModel: The main screen's view model. It holds the `LocationManager` and `ShiftsRepository`. Also, it contains the logic for infinite scroll and pull to refresh. Finally, it uses `Combine` to fetch data and assign it to a view's state.
   - The user's location is requested to show the distance to shift's address.
- ShiftsViewModel: The view model representing the shifts keyed by the day.
- ShiftViewModel: The view model representing a shift. It receives the `ShiftModel` and makes it to be present in the cell.

### Tests

The view models are heavily tested, specifically the screen one. It contains many scenarios including the pull to refresh, infinite scroll, and states over many repository outcomes.