#!/bin/sh -eux

lvextend -l +100%FREE /dev/mapper/debian--vg-debian--lv
resize2fs /dev/mapper/debian--vg-debian--lv