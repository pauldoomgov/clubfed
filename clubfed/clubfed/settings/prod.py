import os

from pathlib import Path

import dj_database_url

from django.utils.crypto import get_random_string

from .base import *  # noqa

# spell out explicit variable dependencies
from .base import DATABASES, MIDDLEWARE

from .env import env

BASE_DIR = Path(__file__).resolve().parent.parent

USE_X_FORWARDED_HOST = True

STATIC_ROOT = "/app/clubfed/clubfed/static/"
STATIC_URL = "/clubfed/static/"

DATABASES["default"] = dj_database_url.config()

SECRET_KEY = env.get_credential("DJANGO_SECRET_KEY", get_random_string(50))

ALLOWED_HOSTS = os.environ.get("ALLOWED_HOSTS", "").split(",")

SESSION_COOKIE_SECURE = True
SESSION_COOKIE_HTTPONLY = True
CSRF_COOKIE_SECURE = True
CSRF_COOKIE_HTTPONLY = True


MIDDLEWARE.append("csp.middleware.CSPMiddleware")
allowed_sources = (
    "'self'",
    # CHANGEME: put the real hostname of the application here
    "clubfed.agency.gov/",
)
CSP_DEFAULT_SRC = allowed_sources
CSP_SCRIPT_SRC = allowed_sources
CSP_IMG_SRC = allowed_sources
CSP_MEDIA_SRC = allowed_sources
CSP_FRAME_SRC = allowed_sources
CSP_WORKER_SRC = allowed_sources
CSP_FRAME_ANCESTORS = allowed_sources

CSP_STYLE_SRC = (
    "'self'",
    "'unsafe-inline'",
)
CSP_FONT_SRC = allowed_sources
CSP_INCLUDE_NONCE_IN = ["script-src"]

LOGGING = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {
        "verbose": {
            "format": "[%(asctime)s] %(levelname)s [%(name)s:%(lineno)s] "
            "%(message)s",
            "datefmt": "%d/%b/%Y %H:%M:%S",
        },
        "simple": {
            "format": "%(levelname)s %(message)s",
        },
    },
    "handlers": {
        "file": {
            "level": "DEBUG",
            "class": "logging.FileHandler",
            "filename": os.path.join(BASE_DIR, "logs/tock.log"),
            "formatter": "verbose",
        },
        "console": {
            "level": "INFO",
            "class": "logging.StreamHandler",
            "formatter": "verbose",
        },
    },
    "loggers": {
        "django": {
            "handlers": ["console", "file"],
            "propagate": True,
            "level": os.getenv("DJANGO_LOG_LEVEL", "DEBUG"),
        },
        "django.template": {
            "handlers": ["console", "file"],
            "propagate": True,
            "level": "INFO",
        },
        "clubfed": {
            "handlers": ["console", "file"],
            "propagate": True,
            "level": "INFO",
        },
    },
}
