# SendGrid Consumer API Visualization

The SendGrid API Visualization application allows a SendGrid client to enter their API key into the Client ID field, select a date range, and see a visual representation of the email events that occurred on a per provider basis.

## Getting Started

To use the application, simply clone this repo onto your local machine and follow the steps below. The application is not currently deployed to a web server, but will run the same locally when the proper environment is configured.

The application does not store any user data other than temporary CSV files that are created when the API requests are made. These files do not carry any identifying information about the client, SendGrid or recipients.

### Prerequisites

```
Ruby on Rails
	- Rails version 5.0.1
	- Ruby version 2.3.0 (2.3.1 should also work)
	- Bundled with 1.13.6
PostgreSQL
```

If you don't have rails (or ruby) installed, this [tutorial](http://docs.railsbridge.org/intro-to-rails/) is a good place to start.

## Running the tests

Run the test suite using RSpec. 

### Break down into end to end tests

```
I still need to build out unit testing for the CSV builder and formatter.
```

## Deployment

When your environment is set up, simply start the rails server and visit localhost in your browser.

## Built With

* [HighCharts](http://www.highcharts.com/) - Data Visualization

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags).

## Authors

* **Nicholas Martinez** - *Initial work* - [NZenitram](https://github.com/NZenitram)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* [**Ali Schlereth**](https://github.com/AliSchlereth):
   She spent a solid hour with me getting HighCharts set up. The key of "thing" created for the API is in her memory.
