#!/usr/bin/env ruby

require 'yaml'
require 'active_support'
require 'active_support/all'


unless ENV['COMPOSE_FILE']
  STDERR.puts "COMPOSE_FILE environment must point to one or more files"
  exit 1
end

tests1 = [
  {
    input1: {a: 1, h: {i: 1}},
    input2: {b: 2, h: {j: 2}},
    result: {a: 1, b: 2, h: {i: 1, j: 2}}
  },
  {
    input1: {a: 1, c: 2, h: {i: 1, j: 2}},
    input2: {a: 2, b: 3, h: {i: 2, k: 3}},
    result: {a: 2, b: 3, c: 2, h: {i: 2, j: 2, k: 3}}
  },
  {
    input1: {a: [1,2]},
    input2: {a: [2,3]},
    result: {a: [1,2,3]}
  }
]

tests2 = [
{
  file: nil,
  template: 'version: "3.4"
services:
  base: 
    image: aaaa
    networks:
      - bus2
    deploy:
      limits:
        memory: 0G
        test: 1111

  db:
    extends: base
    image: postgres:9.6
    networks:
      - bus
    healthcheck:
      test: ["CMD", "pg_isready"]
      interval: 30s
      timeout: 20s
      retries: 3
    deploy:
      limits:
        memory: 2G
      restart_policy:
        condition: on-failure
        delay: 5s
',
result: 'version: "3.4"
services:
  base: 
    image: aaaa
    networks:
      - bus2
    deploy:
      limits:
        memory: 0G
        test: 1111

  db:
    image: postgres:9.6
    networks:
      - bus2    
      - bus
    healthcheck:
      test: ["CMD", "pg_isready"]
      interval: 30s
      timeout: 20s
      retries: 3
    deploy:
      limits:
        memory: 2G
        test: 1111
      restart_policy:
        condition: on-failure
        delay: 5s
'
},
{
file: 'version: "3.4"
services:
  base: 
    image: aaaa
    networks:
      - bus2
    deploy:
      limits:
        memory: 0G
        test: 1111
',
template: 'version: "3.4"
services:
  db:
    extends: 
      file: /tmp/tmp.yml
      service: base
    image: postgres:9.6
    networks:
      - bus
    healthcheck:
      test: ["CMD", "pg_isready"]
      interval: 30s
      timeout: 20s
      retries: 3
    deploy:
      limits:
        memory: 2G
      restart_policy:
        condition: on-failure
        delay: 5s
',
result: 'version: "3.4"
services:
  db:
    image: postgres:9.6
    networks:
      - bus2    
      - bus
    healthcheck:
      test: ["CMD", "pg_isready"]
      interval: 30s
      timeout: 20s
      retries: 3
    deploy:
      limits:
        memory: 2G
        test: 1111
      restart_policy:
        condition: on-failure
        delay: 5s
'
}
]



def extend_hash first, second 
  first.each_pair do |fk, fv|
    next if !second.has_key?(fk)

    sv = second[fk]
    raise "Types of values not match(#{fv.class}, #{sv.class})" if fv.class != sv.class

    if fv.is_a? Hash
      extend_hash(fv, sv)
    elsif fv.is_a? Array
      fv |= sv
      first[fk] = fv
    else
      first[fk] = sv
    end
  end

  second.each_pair do |sk, sv|
    next if first.has_key?(sk)

    first[sk] = sv
  end

  return first
end

def process_compose_hash yml
  (yml["services"] || {}).each_pair do |name, service|
    if ext = service["extends"]
      base = if ext.is_a? String
        yml["services"][ext]
      elsif ext["file"]
        YAML.load(File.read(ext["file"]))["services"][ext["service"]]
      else
        yml["services"][ext["service"]]
      end.deep_dup

      service.delete "extends"
      yml["services"][name] = extend_hash(base, service)
    end
  end
  yml
end

tests1.each do |test|
  input1 = test[:input1]
  input2 = test[:input2]
  result = test[:result]
  raise "error test " if  extend_hash(input1.deep_dup, input2) != result
end

tests2.each do |test|
  File.write("/tmp/tmp.yml", test[:file]) 
  template = test[:template]
  result = test[:result]

  yml = process_compose_hash(YAML.load(template))
  result = YAML.load(result)

  raise "error test2 " if yml != result
end


result = ENV['COMPOSE_FILE'].split(":").reduce({}) do |parent, file|
  yml = process_compose_hash(YAML.load(File.read(file)))

  if yml['version'] && parent['version'] && yml['version'] != parent['version']
    raise "version mismatch: #{file}"
  end

  ret = extend_hash(parent.deep_dup, yml)

  ret
end

if ARGV[0].nil? || ARGV[0].strip == "-"
  puts YAML.dump(result)
else
  File.write(ARGV[0].strip, YAML.dump(result))
end
