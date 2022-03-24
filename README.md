# README
* Use a fake email while signing up
* disclaminer: signing up throws an error due to hackers trying to log into my mailers email. just go back a page and sign in; it will work.

# Project: Building Facebook
You’ve come a long way, congratulations! At this point, you should feel comfortable with building new Rails applications, modelling data, and working with forms. This project will require you to put all your newfound knowledge to the test. It should serve as a great portfolio piece for what you’re capable of. It’ll take some thought and time but it’s certainly within reach of your skills.

You’ll be building Facebook. As usual, any additional styling will be up to you but the really important stuff is to get the data and back end working properly. You’ll put together some of the core features of the platform – users, profiles, “friending”, posts, news feed, and “liking”. You’ll also implement sign-in with the real Facebook by using OmniAuth and Devise.

Some features of Facebook we haven’t yet been exposed to – for instance chat, realtime updates of the newsfeed, and realtime notifications. You won’t be responsible for creating those unless you’d like to jump ahead and give it a shot.

# Assignment
Build Facebook! You’ll build a large portion of the core Facebook user functionality in this project. We won’t be worrying about the Javascript-heavy front end stuff but you won’t need it to get a nice user experience.

You should write at least a basic set of integration tests which let you know if each page is loading properly and unit tests to make sure your associations have been properly set up (e.g. testing that User.first.posts works properly). Run them continuously in the background with Guard (See the Ruby on Rails Tutorial Chapter 3.7.3).

This project will give you a chance to take a relatively high level set of requirements and turn it into a functioning website. You’ll need to read through the documentation on GitHub for some of the gems you’ll be using.

source: https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails/lessons/rails-final-project

BUGS:
* random generated users profile pifctures are broken because there is a bug that creates an activerecord error if I generate them. User can still upload their own pictures and are created with a default picture.
* facebook users can't set a profile picture because their password is tokenized and is needed to save changes.
