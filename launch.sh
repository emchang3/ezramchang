#!/bin/bash

# Provide port number as argument.
puma -b tcp://0.0.0.0:$1

