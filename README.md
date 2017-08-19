# README

My approach for the problem is this:

* Import CSV and create loans from it
* Add a button to view all loans in a table with a download button
* Add a button to download CSV through controller action

As I started this project I saw two ways of implementing the CSV import.

* Import the CSV through a rake task
* Import through UI form

I chose to import through a rake task:
`rake data:import_loans[path_to_file]`

The reason why I chose this route:

* Scale ability, you can upload 10 or a 1_000 without the server timing out
* The user does not have to wait for the form to submit

The third party gems I used for testing are:

* `rspec-rails`
* `shoulda-matchers`
* `factory_girl_rails`
* `rails-controller-testing`

Third party gem for the app:

* `pry-byebug`, I prefer using pry, I have tried using byebug but it just didn't feel right
* `jquery-rails`
* `bootstrap-sass`, I have exclusively worked with bootstrap in the last 4 years

# jumo_loans
