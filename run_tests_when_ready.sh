#!/usr/bin/env bash
timeout 300 bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' zalenium:4444/wd/hub/status)" != "200" ]]; do sleep 5; done' || false
rake cucumber