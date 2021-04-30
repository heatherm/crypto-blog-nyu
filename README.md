# README

This is a reference rails application that shows an implementation with all vital security controls.

## Ruby version

`3.0.0`

## System dependencies

- Postgres 13.2
- Devise for authentication with use of bcrypt
- Minitest

## Configuration

- All routes require authentication

## How to run the test suite

`rails test test/`

## Deployment instructions

- Deployed to Heroku `https://stark-peak-52834.herokuapp.com/`

## Security

### Log-out button
By adding a prominent logout button, we help users to clear out the cookies after working.

### Forcing SSL
By always forcing SSL connection in our application config file for the production environment, we ensure that the cookies cannot be sniffed and help prevent XSS/session fixation. 

### Brakeman Scanning
Brakeman is a command-line tool that analyzes the source code of Ruby on Rails applications to find potential security vulnerabilities.
- Install with `bundle install`
- Run at app root with  `$ brakeman`
- [Result from April 30th](./brakeman_results.txt)

### Dependabot Alerts
Dependabot is integrated on our Github repository to get notified when one of our dependencies has a vulnerability. Dependabot will automatically keep our application up-to-date by updating dependencies in response to these alerts.

