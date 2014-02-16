#!/usr/bin/env bats

@test "yum.conf should have proxy info in it" {
  grep proxy= /etc/yum.conf
}

@test "yum install should work" {
  yum install tree -y
}
