# README

A proof of concept dockerized Ruby on Rails API service including a lcoal dockerized MySQL DB.

# TODOs
See [Issues](https://github.com/the-mom-project/ats_service_poc/issues)

# Get running

### Pre-requisites
* Docker (I'm running Docker for Mac): `docker -v`
```sh
> Docker version 20.10.12, build e91ed57
```
* Docker compose: `docker-compose version`
```
> docker-compose version 1.25.5, build unknown
> docker-py version: 4.4.4
> CPython version: 3.8.9
> OpenSSL version: LibreSSL 2.8.3
```

### Build

```
docker-compose build
```

### Run

```
docker-compose up
```

### Reset your environment (stops containers)

```
docker-compose down
```

### Reset your environment and wipe the database

```
docker-compose down --volumes
```

### Migrate

```
docker-compose run app rails db:migrate
```

### Push image to AWS ECR

As a first step ensure you are logged into AWS CLI SSO.
Then execute the following:

```
aws ecr get-login-password --region us-east-1 --profile main-developer | docker login --username AWS --password-stdin 439494775453.dkr.ecr.us-east-1.amazonaws.com
docker build -t ats_service .
docker tag ats_service:latest 439494775453.dkr.ecr.us-east-1.amazonaws.com/ats_service:latest
docker push 439494775453.dkr.ecr.us-east-1.amazonaws.com/ats_service:latest
```

#### Troubleshooting
In case the first command responded with `Error saving credentials: error storing credentials - err: exit status 1, out: error storing credentials - err: exit status 1, out: The user name or passphrase you entered is not correct.`, 
this has nothing to do with AWS. Rather, docker tried to store the credentials to your local MacOS keychain unsuccessfully. 
The best and easiest fix is to disable this functionality. Just edit the file `~/.docker/config.json` by removing `credsStore` and `credHelpers`. Finally, restart your computer. 

### Setup Rubymine or Idea with Ruby Plugin

In case you use Rubymine or IntelliJ Idea with Ruby Plugin, you will have to setup a remote ruby interpreter in order to use full functionality of the IDE.

There's no need to explicitly install ruby locally on your machine. Instead, Rubymine / Idea will use the remote ruby installed in the docker container. Additionally, all gems will be installed in the docker container instead of your local machine.

#### Rubymine

* Open the "Settings/Preferences" dialog, go to the "Languages & Frameworks | Ruby SDK and Gems" page
* Click the + button and select "Remote Interpreter or Version Manager"
* In the invoked dialog, select "Docker Compose". Select the service "app" and click OK
* Select the added SDK in the Ruby SDK and Gems page and click OK

#### Idea with Ruby Plugin

* Open the "Project Structure" dialog and select the "SDKs" tab
* Click on the + button and select "Add Ruby SDK..." and then "New Remote..."
* In the invoked dialog, select "Docker Compose". Select the service "app" and click OK
* Select the "Project" tab and then select the added SDK from the drop down
* Select the "Modules" tab and then select the added SDK from the list


### Rails console

```
docker-compose run app rails console
```

### Debugging sessions

> Running an interactive debugger (like pry) in your Docker containerIt takes a little extra work to get Docker to allow interactive terminal debugging with tools like byebug or pry. Should you desire to start your web server with debugging capabilities, you will need to use the --service-ports flag with the run command.

Instead of running `docker-compose up` run:

```
docker-compose run --service-ports app
```

### localhost

* http://localhost:6001 (Rails page)
* http://localhost:6001/projects (Displays a project one created)

## Create a project

Create a project in command line
```ruby
Project.create({
  bill_method: "w2",
  budgeted_hours: 40,
  close_reason: "too legit",
  description: "Job for Ruby and Rails",
  external_id: "12346789",
  full_time: true,
  locations: [{zip: 12345}],
  markup: 10,
  number_of_roles: 1,
  preferred_experience_level: "mid",
  project_based: false,
  rate: 80000,
  remote_ok: true,
  remote_percentage: 50,
  request_payload: {},
  start_date: "2022-03-03",
  title: "Assistant to the regional coach",
  travel_required: true
})
```

## Curls

### Create a project

WIP
```sh
curl --location --request POST 'localhost:6001/projects' \
--header 'Content-Type: application/json' \
--data-raw '{
  "bill_method": "w2",
  "budgeted_hours": 40,
  "description": "Long form text...\ndescribing the job, that requires Ruby on Rails...etc",
  "external_id": "12341234",
  "employer_id": 1,
  "full_time": true,
  "locations": [
    {
      "city": "Pasadena",
      "state": "CA",
      "zip": "12345"
    }
  ],
  "markup": 10,
  "number_of_roles": 2,
  "preferred_experience_level": "mid",
  "project_based": false,
  "rate": 60000,
  "remote_ok": true,
  "remote_percentage": 20,
  "start_date": "2021-11-01T23:43:40Z",
  "title": "Customer Success Manager",
  "travel_required": false
}'
```
