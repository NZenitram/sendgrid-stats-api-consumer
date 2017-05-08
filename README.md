# SendGrid Consumer API Visualization

![Landing](https://s3-us-west-1.amazonaws.com/sg-stats-assets/SimplyMailStatisticsSignUp.png)
![Providers](https://s3-us-west-1.amazonaws.com/sg-stats-assets/SimplyMailStatisticsProviders.png)
![Change Client](https://s3-us-west-1.amazonaws.com/github-readme-iamges/SG+Landing+Cal.png)



This web application gives a SendGrid Email customer the ability to visualize their email statistical data for a given date range using Highcharts visualization. A user signs up using an email address, confirms sign up via email, then logs in. After log in the user is sent to a landing page to select their email service provider. The only provider currently available is SendGrid. Select SendGrid from the drop down, and the user is redirected to a form that asks for their stats API key (Any key will work but it is recommended that you create a stats only API key for your SendGrid account, API keys are not stored in the DB, the key is used to make the API call to SendGrid, the data is objectified, and sent via API to the backend application that processes and stores the information to a PostgresDB running on AWS). The user can then click through the 'Global', 'Providers' or 'Top Five' links at the top of the page to display the data they wish to view. Single or multiple providers may be selected from the dynamically generated providers list on the providers view. The user can then select if they wish to view raw numerical data, or a subset of percentage data that is generated based on their total deliveries. All user data is currently destroyed on log out. So re-entering your API key is required after each log out. This was done to protect user data and limit the amount of storage required to run the application.

## Getting Started

Visit https://www.simplymailstatistics.com/ and register your account. Please have your SendGrid ReadOnly API key ready. After sign up, confirm your email address through the confirmation email that is sent to your inbox. After confirmation, you can log in and will be redirected to the landing page where you may select your Email provider. As stated above, SendGrid is the only provider currently available. Select SendGrid from the dropdown and you will be asked for your API key and to select a date range. Enter in the fields and click fetch!

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

### The Future

I wish to continue the style out the interface and make it more user friendly. Rate percentages will also be added to make consuming the data more clear and easier to understand. The current API calls and data parsing take a while, and is done on each page reload. I will work on persisting the data per session so when the key is entered, it only needs to work through the response once per client. 

## Deployment

When your environment is set up, simply start the rails server and visit localhost in your browser.

## Built With

* [HighCharts](http://www.highcharts.com/) - Data Visualization

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

* **Nicholas Martinez** - *Initial work* - [NZenitram](https://github.com/NZenitram)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* [**Ali Schlereth**](https://github.com/AliSchlereth):
   She spent a solid hour with me getting HighCharts set up. The key of "thing" created for the API is in her memory.
