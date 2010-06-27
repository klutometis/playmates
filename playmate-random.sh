#!/usr/bin/env bash
playmates=($(ls "$1"/*.jpg))
echo ${playmates[$(( $RANDOM % ${#playmates[@]} ))]}
