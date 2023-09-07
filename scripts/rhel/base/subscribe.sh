#!/bin/sh -eux

sudo subscription-manager register --username $REDHAT_USERNAME --password $REDHAT_PASSWORD
sudo subscription-manager attach