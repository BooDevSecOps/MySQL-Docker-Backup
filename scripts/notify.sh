#!/bin/bash

source "$(dirname "$0")/../.env"

BODY=$1

echo "$BODY" | mail -s "$EMAIL_SUBJECT" -r "$EMAIL_SENDER" "$EMAIL_RECEIVER"
