### Usage
    $ bundle install
    $ sequel -m db/migrations sqlite://db/database.db
    $ foreman start
    
Create `.env` file and add following variables:
```
CLIENT_ID=your_inst_client_id
CLIENT_SECRET=your_inst_client_secret
REDIRECT_URI=http://localhost:8080/
```    
    
### Testing
    $ sequel -m db/migrations sqlite://db/test.db
    $ rspec
     
### Heroku 
    $ heroku login
    $ heroku create
    $ git push heroku master
    $ heroku run sequel -m db/migrations/ "$(heroku config:get DATABASE_URL)"
    $ heroku restart
    $ heroku config:set CLIENT_ID=your_inst_client_id 
    $ heroku config:set CLIENT_SECRET=your_inst_client_secret 
    $ heroku config:set REDIRECT_URI=your_redirect_uri
