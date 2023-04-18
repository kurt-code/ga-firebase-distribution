#!/bin/bash

# Input string
output_string=$1

# Regex pattern to match the firebase console uri
firebase_console_regex="https:\/\/console\.firebase\.google\.com\/project\/[^\/]+\/appdistribution\/app\/android:[^\/]+\/releases\/[a-zA-Z0-9]+"

# Regex pattern to match the testing uri
testing_regex="https:\/\/appdistribution\.firebase\.google\.com\/testerapps\/[0-9]+:[^\/]+\/releases\/[a-zA-Z0-9]+"

# Regex pattern to match the binary download uri
binary_download_regex="https:\/\/firebaseappdistribution\.googleapis\.com\/app-binary-downloads\/projects\/[0-9]+\/apps\/[0-9]+:[^\/]+\/releases\/[a-zA-Z0-9]+\/binaries\/[a-zA-Z0-9]+\/app\.apk"

# Check for error in the output string
if [[ "$output_string" =~ "Error" ]]; then
  error_message="$output_string"
  firebase_console_uri=""
  testing_uri=""
  binary_download_uri=""
  # Print the extracted URLs and error message
  echo "FAILED"
  echo "Error message: $error_message"
  echo "error_message=$error_message" >> "$GITHUB_OUTPUT"
  echo "upload_status=failure" >> "$GITHUB_OUTPUT"
#  exit 1
else
  # Extract firebase console uri
  if [[ "$output_string" =~ $firebase_console_regex ]]; then
    firebase_console_uri="${BASH_REMATCH[0]}"
  fi

  # Extract testing uri
  if [[ "$output_string" =~ $testing_regex ]]; then
    testing_uri="${BASH_REMATCH[0]}"
  fi

  # Extract binary download uri
  if [[ "$output_string" =~ $binary_download_regex ]]; then
    binary_download_uri="${BASH_REMATCH[0]}"
  fi

  # Check if all URLs were extracted successfully
  if [[ -z "$firebase_console_uri" || -z "$testing_uri" || -z "$binary_download_uri" ]]; then
    error_message="Failed to extract URLs from output string"
    echo "WARNING: $error_message"
    echo "error_message=$error_message" >> "$GITHUB_OUTPUT"
    echo "upload_status=warning" >> "$GITHUB_OUTPUT"
  else
    error_message=""
    echo "SUCCESS"
    echo "Firebase Console URI: $firebase_console_uri"
    echo "Testing URI: $testing_uri"
    echo "Binary Download URI: $binary_download_uri"
    echo "error_message=$error_message" >> "$GITHUB_OUTPUT"
    echo "upload_status=success" >> "$GITHUB_OUTPUT"
    echo "firebase_console_uri=$firebase_console_uri" >> "$GITHUB_OUTPUT"
    echo "testing_uri=$testing_uri" >> "$GITHUB_OUTPUT"
    echo "binary_download_uri=$binary_download_uri" >> "$GITHUB_OUTPUT"
  fi
#  exit 0
fi


