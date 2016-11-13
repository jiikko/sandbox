#!/bin/bash

service postgresql start

echo "gem: --no-ri --no-rdoc" > ~/.gemrc

while [[ true ]]; do
  bash
done
