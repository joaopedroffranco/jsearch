# JFoundation

Package responsible for shareable code and logic that may be used across the app's features.

Besides that, it also holds some extensions and utils code related to anything that may be useful.

### Location

It contains logic related to getting the user's location. It contains the default implementation `LocationManager` wrapping the native location manager through a protocol `LocationProtocol`.

The engineer may request the user authorization and get the latest user's location.

### Logger

It contains the logic related to debugging messages, to not show explicit `prints` along the code.

### Router

It contains router logic. The `RouterProtocol` and `RouterDelegate` are navigation standards for any flow in the app.

A `RouterProtocol` contains a strong reference to the next one and a weak to the parent. Moreover, each router owns your children's controller/view and how they're going to be shown (such as pushed or modally).

Those children have also a weak reference through the `RouterDelegate` of the referred router to tell it to navigate if needed (such as dismissing or tapping a button).