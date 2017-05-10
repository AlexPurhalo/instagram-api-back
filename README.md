### Usage
    $ bundle install
    $ sequel -m db/migrations sqlite://db/database.db
    $ foreman start
    
### Testing
    $ sequel -m db/migrations sqlite://db/test.db
    $ rspec
     
### Heroku 
    $ heroku login
    $ heroku create
    $ git push heroku master
    $ sequel -m db/migrations/ "$(heroku config:get DATABASE_URL)"
    $ heroku restart
