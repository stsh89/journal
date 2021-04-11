#!/bin/sh

/app/bin/journal eval "Journal.Release.migrate" && /app/bin/journal start
