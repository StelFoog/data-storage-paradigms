# Starting the database

To start the database and admin interface use `make start` or, if you want it to run in the background use `make start-bg`. These commands will start a docker container with the postgres database service running on port `5432` and pgAdmin service on port `5050`.

## First time

When starting the database first time we have to initiate the database with the schema and data we want it to contain and connect pgAdmin to our database.

Run `make start-bg` to start the database and pgAdmin in the background.

### The database

1. `make migrate` migrates the database to use our schema
2. (optional) `make seed` fills the database with sample data

### pgAdmin

1. Open a browser and open [localhost:5050](http://localhost:5050).
2. Sign in to pgAdmin

```
email: admin@admin.com
password: 123
```

3. Right click on `Servers` in the menu on the left and select `Register > Server...`.
4. Fill out the opened modal:

`General` tab

```
name: soundgood-postgres
```

`Connection` tab

```
Host name/address: host.docker.internal
Port: 5432
Maintnance database: postgres
Username: postgres
Password: 123
```

5. Save the connection.

## Working with pgAdmin

To get started navigate to `soundgood-db` in the menu.

1. Make sure the docker container is up and running. Otherwise you can start it up with `make start`/`make start-bg`.
2. In the menu on the left navigate to `Servers > soundgood-postgres > Databases > soundgood-db`.

### New SQL script

1. Create a new script by navigating to `Object > CREATE Script` in the topbar.
2. Run the script by pressing the play button.

### View/Edit table

1. Navigate to `... > soundgood-db > Schemas > public > Tables`
2. Right click on the table you want and select `View/Edit Data > All Rows`.

- A row can be deleted by selecting it and pressing the trash can icon.
- A row can be added by pressing the icon with three rows and a plus.
- The value of a row can be edited by double clicking the attribute you want to change.
