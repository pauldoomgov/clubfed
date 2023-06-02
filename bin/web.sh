#!/bin/bash

# Run Django web app under gunicorn

set -o errexit
set -o pipefail

cd clubfed

# Only run migrations on the zeroth index when in a cloud.gov environment
if [[ -v CF_INSTANCE_INDEX && $CF_INSTANCE_INDEX == 0 ]]
then
  python manage.py migrate --settings=clubfed.settings.prod --noinput
else
  echo "Migrations did not run."
  if [[ -v CF_INSTANCE_INDEX ]]
  then
    echo "CF Instance Index is ${CF_INSTANCE_INDEX}."
  fi
fi


if [[ -f VERSION ]]
then
  VERSION=$(cat VERSION)
else
  VERSION="Manual Deployment"
fi

DEPLOYMENT_DESCRIPTION="Recording deployment of ${VERSION}."

echo "${DEPLOYMENT_DESCRIPTION}"

python manage.py collectstatic --settings=clubfed.settings.prod --noinput
gunicorn -t 120 -k gevent -w 2 clubfed.wsgi:application
