#!/usr/bin/env ruby

require 'open3'

pid = Integer(ARGV[0])

def call(code)
  puts "[INFO] Injecting payload: #{code.inspect}"
  return "call (void)rb_eval_string(#{code.inspect})\n"
end

cmd = "gdb -p #{pid}"
Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
  stdin.puts call("require '#{Dir.pwd}/why.rb'")
  stdin.puts call("Why.start")
  stdin.puts "continue\n"
  stdin.close
  $stdout.puts stdout.read
  $stderr.puts stderr.read
  wait_thr.value
end
