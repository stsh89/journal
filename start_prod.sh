#!/bin/bash

_build/prod/rel/journal/bin/journal eval "Journal.Release.migrate" &&
  _build/prod/rel/journal/bin/journal start
