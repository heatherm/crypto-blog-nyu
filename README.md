# README

This is a reference rails application that shows an implementation with all vital security controls.

## Ruby version

`3.0.1`

## System dependencies

- Postgres 13.2
- Devise for authentication with use of bcrypt
- Minitest

## Configuration

- All routes require authentication

## How to run the test suite

`rails test test/`

## Deployment instructions

- Deployed to Heroku at [https://crypto-blog-nyu.herokuapp.com/](https://crypto-blog-nyu.herokuapp.com/)
- To commit:

```
git remote add heroku https://git.heroku.com/crypto-blog-nyu.git
git push heroku main
```

# Security

## To Deal with Broken Authentication Attacks & Sensitive Data Exposure

### Devise authentication
To restrict our Rails application to authorized users, we utilize a flexible authentication solution called Devise.

Devise consists of 10 modules, but we use only those that are in use:

1. Database Authenticatable: hashes and stores a password in the database to validate the authenticity of a user while signing in. The authentication can be done both through POST requests or HTTP Basic Authentication.
2. Registerable: handles signing up users through a registration process, also allowing them to edit and destroy their account.
3. Recoverable: resets the user password and sends reset instructions.
4. Validatable: provides validations of email and password. It's optional and can be customized, so you're able to define your own validations.

The Database Authenticatable module allows the administrator to choose which hashing engine is used for password storage. Our application uses the salted bcrypt hashing specification which is based on the Blowfish cipher. Blowfish is a Feistel cipher of 16 rounds with key-dependent S boxes. Its key-stretching implementation in bcrypt benefits from the inefficiency of computing the hash, making dictionary attacks impractical. 

Passwords stored in the database consist of four components: 
1. An algorithm specifier
2. A cost factor (key expansion iteration count as a power of 2)
3. A 16-byte (128-bit) salt, base64-encoded to 22 characters
4. A 24-byte (192-bit) hash, base64-encoded to 31 characters

`$ [2a] $ [12] $ [PatU75NHDIYaArAF5I1b2u] [RjMQL78cPn5RX5VcVtKEKknzR8Qh3N.]`

This above password was created by the 2a bcrypt specification and it uses 2^12 = 4096 key expansion iterations. 

### Multi-Factor Authentication
We use a Twilio [plugin](https://github.com/twilio/authy-devise) for devise here with developer two factor auth practices followed.

Authy has several options to receive a one-time passcode. The first two options receive the passcode via an SMS message or a phone call. These, however, have been exploited by porting a user’s phone number (also known as SIM Swapping) to gain control of the phone number. The more secure alternative is a software-generated and time-based passcode that is displayed within an authenticator mobile app. And a more convenient variation of this method sends a push notification to the mobile application allowing the user to quickly accept or reject the authentication attempt.  

Storing the Authy API key in plaintext within the web application risks an attacker gaining access to the secret key. To reduce this risk we utilized [Rails encrypted credentials](https://kirillshevch.medium.com/encrypted-secrets-credentials-in-rails-6-rails-5-1-5-2-f470accd62fc). This feature generates a 128-bit AES key and stores it in /config/master.key. This key decrypts /config/credentials.yml.enc, allowing the application administrator to access the file’s contents within a terminal editor to store application secrets. The key file remains stored locally while the application is deployed, yet the necessary secrets are still accessible to any developers that have the key file. 

### Password validation
We have implemented client and server side validation for passwords and have aligned our password policies with NIST 800-63 B’s guideline: Memorized secrets SHALL be at least 8 characters in length if chosen by the subscriber.

### Forcing SSL
By always forcing SSL connection in our application config file for the production environment, we ensure that the cookies cannot be sniffed and help prevent XSS/session fixation. 

### Secure cookie flag and Set HSTS Headers on Responses
Our app specifies itself as HTTPS-only to complying browsers. The minimum required expire time to qualify for browser preload lists is 1 year, so that is what we have it set to.

### Obvious Log-out button
By adding a prominent logout button, we help users to clear out the cookies after working.

### Session Management
We use a server-side, secure, built-in session manager that generates a new random session ID with high entropy after login.

We also provide a secure “cookie-jar”, or encrypted location to store session data. The encryption key, as well as the verification key used for signed cookies, is derived from the secret key configuration value.


## Infrastructure to Support Security Health 

### Brakeman Scanning
Brakeman is a command-line tool that analyzes the source code of Ruby on Rails applications to find potential security vulnerabilities.
- Install with `bundle install`
- Run at app root with  `$ brakeman`
- [Result from April 30th](./brakeman_results.txt)

### Dependabot Alerts
Dependabot is integrated on our Github repository to get notified when one of our dependencies has a vulnerability. Dependabot will automatically keep our application up-to-date by updating dependencies in response to these alerts.

### Logging & Monitoring
Our implementation is hosted on heroku's infrastructure where we make use of two additional resources. Papertrail is used for logging and alerting of app side content. Librato is monitoring and alerting on server, virtual host, and container health.
