#!/usr/bin/env bats

@test "apt.conf should have proxy info in it" {
  grep Acquire::http::Proxy /etc/apt/apt.conf
}

@test "apt-get should work" {
  apt-get install tree -y
}
