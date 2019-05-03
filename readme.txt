Υλοποίηση σε ruby on rails (rails 5.1.6). Επιλέχθηκε ώστε ενσωματώνει τις αρχές της αρχιτεκτονικής REST και το Model-View-Controller pattern.
Χρήση bootstrap-sass 3.3.7
Heroku deployment with SSL: https://arcane-reef-86280.herokuapp.com

Στοιχεία admin:
email: example@railstutorial.org
password: foobar 

Χρησιμοποιούνται seeds (net-work/db/seeds.rb) για τη μαζική δημιουργία χρηστών.

Περνάει επιτυχώς από unit και integration testing που αναπτύχθηκε στα πλαίσια της εργασίας. (rails test)

Έχει υλοποιηθεί το bonus ερώτημα. 

Set-up:

bundle install --without production
rails db:migrate
rails test
rails server
