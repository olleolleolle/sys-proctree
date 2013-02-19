sys-proctree
============

Discovers and lays waste to process trees on various operating systems.

Guide
-----

* gem install sys-proctree

```ruby
    require 'sys/proctree'

    ::Process.kill_tree(9, 2134) # Kills process with pid 2134 and it's children using 9 as the kill signal for each process
```

Dependencies
------------

Uses sys-proctable to discover process trees.  See sys-proctable for supported operating systems.

Requirements
------------

* Ruby 1.9.3
