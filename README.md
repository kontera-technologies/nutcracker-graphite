Nutcracker Graphite
==================
<a href="https://rubygems.org/gems/nutcracker-graphite"><img src=https://fury-badge.herokuapp.com/rb/nutcracker-graphite.png></a>

[Nutcracker](https://github.com/kontera-technologies/nutcracker) plugin for sending cluster data to Graphite

### DISCLAIMER
this is still a work in progress...

## Dependencies
- ruby 1.9+
- [Graphite](http://graphite.wikidot.com/)

## Installation 
Add this line to your application's Gemfile:
```
gem 'nutcracker-graphite'
```

And then execute:
```
$ bundle install
```

or just by
```
$ gem install nutcracker-graphite
```

## Usage
example app
```ruby
require 'nutcracker'
require 'nutcracker/graphite'

# Start nutcracker
nutcracker = Nutcracker.start(cluster: 'cluster.conf')

# Start Graphite stats agent
nutcracker.use(:graphite, graphite: 'graphite.example.com')
# will send aggregated stats to graphite.example.com every 1 minute

# Waiting....
nutcracker.join
```

example output for two nodes cluster ( will be send every 1 minute )
```
nutcracker.<cluster-name>.<nutcracker-hostname>.client_eof 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.client_err 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.client_connections 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.server_ejects 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.forward_error 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.fragments 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.cluster_server_eof 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.cluster_server_err 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.cluster_server_timedout 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.cluster_server_connections 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.cluster_requests 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.cluster_request_bytes 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.cluster_responses 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.cluster_response_bytes 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.cluster_in_queue 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.cluster_in_queue_bytes 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.cluster_out_queue 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.cluster_out_queue_bytes 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.connections 95.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.used_memory 20173789840.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.used_memory_rss 20932427776.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.fragmentation 1.04 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.expired_keys 36732182.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.evicted_keys 12284.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.hits 1372163466.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.misses 58928722.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.keys 24347281.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.max_memory 21474836480.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node1>.hit_ratio 0.96 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.cluster_server_eof 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.cluster_server_err 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.cluster_server_timedout 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.cluster_server_connections 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.cluster_requests 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.cluster_request_bytes 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.cluster_responses 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.cluster_response_bytes 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.cluster_in_queue 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.cluster_in_queue_bytes 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.cluster_out_queue 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.cluster_out_queue_bytes 0.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.connections 95.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.used_memory 20173789840.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.used_memory_rss 20932427776.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.fragmentation 1.04 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.expired_keys 36732182.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.evicted_keys 12284.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.hits 1372163466.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.misses 58928722.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.keys 24347281.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.max_memory 21474836480.0 1369569180
nutcracker.<cluster-name>.<nutcracker-hostname>.<node2>.hit_ratio 0.96 1369569180
```

