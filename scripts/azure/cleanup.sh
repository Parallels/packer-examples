#!/bin/bash
# Clean up cache to reduce image size
sudo tdnf clean all
sudo rm -rf /tmp/*