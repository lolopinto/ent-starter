# ent-starter

This assumes Postgres installed and being used. Other options:

* [postgres docker image](#postgres-docker-image)
* [sqlite](#sqlite)

Steps:

* Install [Docker](https://docs.docker.com/get-docker/)
* Run `createdb ent-starter` (replace with name of your app)
* update db credentials in `docker-compose.dev.yml` by changing `DB_CONNECTION_STRING` environment variable
* Run `npm run codegen` after making any changes to the schema
* Make sure to run `npm run compile` after making any changes to the code and before running `npm start`

Example schema change:

```ts
// src/schema/user.ts
// this adds a User object with a firstName and lastName
import { BaseEntSchema, Field, StringType } from "@snowtop/ent";

export default class User extends BaseEntSchema {
  fields: Field[] = [
    StringType({ name: "FirstName" }),
    StringType({ name: "LastName" }),
  ];
}
```

For a full intro, check out the [docs](https://ent.dev/docs/intro#your-first-schema).

## upgrading base image

Note that when the base image is changed, e.g. when upgrading the ent package image, you should rebuild the image as follows: `docker-compose -f docker-compose.dev.yml build` so as to not be stuck with an old image and not see the changes from the new version.

A list of available images can be seen by running the following command: `docker image ls`. If you see an image with repository `{container-name}_app` e.g. `ent-starter_app` that's from a couple weeks or months ago after upgrading the base image, that's the issue you're running into.

## postgres docker image

Instead of installing Postgres and having to deal with a local install, you can use the postgres image. Follow these steps to get started:

* uncomment out the section in `docker-compose-dev.yml` referring to the `db` service
* change the `DB_CONNECTION_STRING` line in the environment section of the `app` service to `DB_CONNECTION_STRING=postgres://postgres:postgres@db/ent-starter`
* update `.gitignore` to add `postgres_data` so as to not check in the postgres files.
* Add `psql` as a script to the `scripts` section of `package.json` with value `docker-compose -f docker-compose.dev.yml run --rm db psql ent-starter -h db -U postgres` to make it easy to query the database.

Note that the following commands require the database to be available and listening to connections before they can succeed:

* `npm run codegen`
* `npm run upgrade`
* `npm run psql`

The easiest way to solve this is by updating the `start` script in `package.json` to `docker-compose -f docker-compose.dev.yml up -d` to run in [detached mode](https://docs.docker.com/compose/reference/up/).

Now, all the above commands should work.

When done, run `docker container ls | grep ent-starter  | cut -d " " -f 1 | xargs docker stop` to stop all containers.

If you don't go with that approach, have the containers available in one terminal window by running `npm start` and then run the other command such as `npm run upgrade` in a different terminal window or tab.

## sqlite support

* Need to run `npm install better-sqlite3` to install sqlite dependency.
* Add `sqlite-init` to the `scripts` section of package.json with value `rm -rf node_modules && docker-compose -f docker-compose.dev.yml run --rm app npm install`
* Run `npm run sqlite-init` to initialize things/install dependencies. Anytime a new dependency is added, have to run `npm run sqlite-init` to install in the container.
* change the `DB_CONNECTION_STRING` line in the environment section of the `app` service to `DB_CONNECTION_STRING=sqlite:///ent-starter2.db`
