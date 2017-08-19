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



* ...
# jumo_loans
