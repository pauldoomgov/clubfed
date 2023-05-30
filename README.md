# Clubfed
========================

<<TKTK: quick summary of project>>

## Development

If you're new to Django, see [Getting Started with
Django](https://www.djangoproject.com/start/) for an introduction to the
framework.

### Local Setup

* Install Docker <https://docs.docker.com/get-docker/>
* Initialize the application:

  ```shell
  docker-compose build
  docker-compose run app python manage.py migrate
  ```
* Run the server: `docker-compose up`
* Visit the site: http://localhost:8000

### Local Configuration

## Security

### Authentication

TBD

### Inline `<script>` and `<style>` security

The system's Content-Security-Policy header prevents `<script>` and `<style>`
tags from working without further configuration. Use `<%%= javascript_tag
nonce: true %>` for inline javascript.

See the [CSP compliant script tag helpers](./doc/adr/0004-rails-csp-compliant-script-tag-helpers.md) ADR for
more information on setting these up successfully.

## Internationalization

## Testing

### Running tests

* Tests: `pipenv exec pytest`
* Python linter: `pipenv exec black`
* Accessibility scan: `./bin/pa11y-scan`
* Dynamic security scan: `docker-compose run owasp`
* Static security scan: `pipenv run bandit -r .`
* Python dependency checks: `pipenv check`
* JS dependency checks: `./yarn audit`

#### Pa11y Scan

When new pages are added to the application, ensure they are added to
`./.pa11yci` so that they can be scanned.

### Automatic linting

To enable automatic Python linting on every `git commit` follow the instructions
at the top of `.githooks/pre-commit`

## CI/CD

### Deployment

Each environment has dependencies on a PostgreSQL RDS instance managed by cloud.gov.
See [cloud.gov docs](https://cloud.gov/docs/services/relational-database/) for information on RDS.

#### Staging

Before the first deploy only, create DB service with `cf create-service aws-rds micro-psql <%= app_name %>-rds-staging`

`cf push --strategy rolling --vars-file config/deployment/staging.yml --var rails_master_key=$(cat config/master.key)`


#### Production

Before the first deploy only, create DB service with `cf create-service aws-rds <<SERVICE_PLAN_NAME>> <%= app_name %>-rds-production`

`cf push --strategy rolling --vars-file config/deployment/production.yml --var rails_master_key=$(cat config/credentials/production.key)`


### Configuring ENV variables in cloud.gov

All configuration that needs to be added to the deployed application's ENV should be added to
the `env:` block in `manifest.yml`

Items that are both **public** and **consistent** across staging and production can be set directly there.

Otherwise, they are set as a `((variable))` within `manifest.yml` and the variable is defined depending on sensitivity:

#### Credentials and other Secrets

#### Non-secrets

Configuration that changes from staging to production, but is public, should be added to `config/deployment/staging.yml` and `config/deployment/production.yml`

## Documentation

### Architectural Decision Records

Architectural Decision Records (ADR) are stored in `doc/adr`
To create a new ADR, first install [ADR-tools](https://github.com/npryce/adr-tools) if you don't
already have it installed.
* `brew bundle` or `brew install adr-tools`

Then create the ADR:
*  `adr new Title Of Architectural Decision`

This will create a new, numbered ADR in the `doc/adr` directory.

Compliance diagrams are stored in `doc/compliance`. See the README there for more information on
generating diagram updates.

## Contributing

*This will continue to evolve as the project moves forward.*

* Pull down the most recent main before checking out a branch
* Write your code
* If a big architectural decision was made, add an ADR
* Submit a PR
  * If you added functionality, please add tests.
  * All tests must pass!
* Ping the other engineers for a review.
* At least one approving review is required for merge.
* Rebase against main before merge to ensure your code is up-to-date!
* Merge after review.
  * Squash commits into meaningful chunks of work and ensure that your commit messages convey meaning.

## Story Acceptance

TBD