#!/bin/sh -eux

sudo subscription-manager remove --all
sudo subscription-manager unregister
sudo subscription-manager clean
