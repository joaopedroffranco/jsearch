# JData

Package responsible for getting and holding data sources. Moreover, it contains the network layer through repositories.

### Data Sources

The protocol `RemoteDataSourceProtocol` defines how the engineer can fetch the data. There is a default implementation `URLSessionDataSource`, using the native `URLSession`.

It uses `Combine` to send a data.

To fetch data, you may create a request using the protocol `Requestable`, and then introduce any new API integration.

- TemperRequest: integrates the temper API `temper.works/api/v3/shifts`

### Repositories

It contains repositories to send decoded models.

All the models are public protocols to be imported in the preferred usage. The response models are package private as they don't matter for final usage, only for decoding.

The repositories integrate a `RemoteDataSourceProtocol` to fetch data.

It also uses `Combine` to send a `Future` decoded data.

### Tests

The repository is tested to expect an outcome given a JSON input.