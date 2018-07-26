#!/usr/bin/env bats

@test "google should be immediately found" {
  run ./wait-for google.com:80 -q -- echo 'success'
  
  [ "$output" = "success" ]
}

@test "nonexistent server should not start command" {
  run ./wait-for -t 1 noserver:9999 -- echo 'success'

  [ "$status" -ne 0 ]
  [ "$output" != "success" ]
}

@test "google & github should be immediately found" {
  run ./wait-for google.com:80 github.com:80 -- echo 'success'
}

@test "nonexistent server and google should not start command" {
  run ./wait-for -t 1 google.com:80 noserver:9999 -- echo 'success'

  [ "$status" -ne 0 ]
  [ "$output" != "success" ]
}
