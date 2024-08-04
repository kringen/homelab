#!/bin/bash

podman run -i --rm quay.io/coreos/butane --pretty --strict < ignition_butane.bn | tee ignition_template.cfg