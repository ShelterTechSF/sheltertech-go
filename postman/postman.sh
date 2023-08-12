#!/bin/sh

set -ex

make ci-run

newman run postman/AskDarcel%20API.postman_collection.json -g postman/globals.postman_globals.json
newman run postman/AskDarcel%20Admin%20API.postman_collection.json -g postman/globals.postman_globals.json
