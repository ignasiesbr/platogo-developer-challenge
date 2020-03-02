# README

Parking-lot API

The majority of the logic can be found in app/controllers/api/ticket_controller.rb

The commits doesn't include the one to switch to Postrgresql db to deploy into Heroku on the following link:

[Heroku link](https://evening-shelf-47299.herokuapp.com/)

Endpoints: 

* POST https://evening-shelf-47299.herokuapp.com/api/tickets/ (Task 1)
* GET https://evening-shelf-47299.herokuapp.com/api/tickets/:barcode (Task 2)
* POST https://evening-shelf-47299.herokuapp.com/api/tickets/:barcode/payments (Task 3) Accepts JSON content like { "payment_method": "CASH" } as a body of the request.
* GET https://evening-shelf-47299.herokuapp.com/api/tickets/:barcode/state (Task 4)
* GET https://evening-shelf-47299.herokuapp.com/api/free-spaces (Task 5)
