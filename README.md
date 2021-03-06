# Clicker

Clicker is a web app that allows teachers to create questions to survey the class during lecture. The teacher will see the results in real time.

## User Stories (goal)

- As a teacher, I want to sign in with GitHub
- As a teacher, I want to create a class
- As a teacher, I want to add other student accounts to a class
- As a teacher, I want to create a question set
- As a teacher, I want to create multiple choice questions for a question set
- As a teacher, I want to open and close questions for students to answer
- As a teacher, I want to see who has and has not yet answered an open question.

- As a student, I want to sign in with GitHub
- As a student, I want to see all my classes
- As a student, I want to answer an opened question.

## User Stories (later)

- As a teacher, I want to create a short answer question
- As a teacher, I want to have a easy-to-say password for students to navigate to the question set
- As a teacher, I want to reorder questions
- As a teacher, I don't want students to see a question until I open it
- As a teacher, after I close a question, I want to be able to anonymously present a student's answer
- As a teacher, after I close a question, if no one gets the answer, I want to present a prepared answer
- As a teacher, I want to be able to give feedback on individual student answers
- As a student, if the question is still open, I want to resubmit my answer if I made a mistake
- As a student, I want to be able to view past question sets I participated in.

## Team

**UI Team**

- Allison Zadronzy (@allizad)
- Randy Davis (@RandyDavis)

**Frontend / JavaScript Team**

- Quin Adney (@quinadney)
- Brian Patternson (@brianpatterson)

**Backend / JavaScript Team**

- Catherine O'Niell (@cath-oneill)
- Christine Oen (@christineoen)
- Joseph Tingsanchali (@lolptdr)

### Implementing a Feature

1. Create a new branch for issue
2. Write and commit some failing tests
3. Create a Pull Request for the issue
4. Get tests reviewed. In the mean time, start implementing the feature
5. If review results in changes/fixes, write and push those changes, then go back to #4
6. Once you've implemented a feature, request a final review.
7. If review results in changes/fixes, write and ppush those changes, then go back to #6
8. If everything's good, your changes will be merged in
9. High five your teammates!

### Development: Using Figaro Gem for OmniAuth authentication with Github

1. Add the `gem 'figaro'` to your Gemfile.
2. Type `rails generate figaro:install` in terminal to generate '/config/application.yml' file. This will also add this file to the .gitignore file.
3. Add your Github ID and Github SECRET to the application.yml file.
4. Ensure ENV hash values are referencing the Github ID and Github SECRET in initializer file 'omniauth.rb'.
5. Run rails server and go to http://localhost:3000 for the app. 

#### For NGINX Configuration for Multiple Servers for Development

6. If you are configuring for NGINX multiple servers, add `HOSTNAME: app.clicker.dev` to your application.yml.
7. Add `OmniAuth.config.full_host = "http://#{ENV['HOSTNAME']}"` to the initializer file 'omniauth.rb'.
8. Run "export DATABASE_URL='postgres://localhost/clicker_dev'" in your terminal.
9. Run your rails server and use http://app.clicker.dev for the app.
