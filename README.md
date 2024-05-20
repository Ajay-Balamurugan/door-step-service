# Description :
Doorstep Service is a full stack Ruby on Rails application which allows customers to book home services and track their orders. It allows admins to manage services and and bookings and lets employees carry out the assigned services.

# Ruby and Rails version :
Ruby Version : 3.2.2

Rails Version : 7.1.3.2

# Installation :

To get started with this project, follow these steps :

1. After cloning the repository, run "bundle install" to install all the required gems and dependencies.

2. Run "rails db:create" to create the database.

3. Run "rails db:migrate" to apply any pending migrations.

4. Run "rails db:seed" to populate the database with seed data.

# Usage :
To use the application, follow these steps:

Run "rails server" to start the server.

Login/Sign up to start using the application.

# Gems Used : 

1. Devise - Authentication
2. active_model_otp - OTP Generatiom
3. Paranoia - Soft Delete
4. twilio-ruby - Sending SMS
5. wicked_pdf - PDF Generation

# Twilio Configuration

Please note that Twilio can be used to send SMS to only twilio verified numbers as a trial account has been used during development.

# Databse Design : 

![door_step_service_final](https://github.com/Ajay-Balamurugan/door-step-service/assets/121103098/b577f12d-36b0-481d-bd2a-c13bd8188e67)

