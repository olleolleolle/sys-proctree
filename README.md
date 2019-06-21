sys-proctree
============

Discovers and lays waste to process trees on various operating systems.

Status
------

[![Build Status](https://travis-ci.org/MYOB-Technology/sys-proctree.png)](https://travis-ci.org/MYOB-Technology/sys-proctree)
[![Gem Version](https://badge.fury.io/rb/sys-proctree.png)](http://badge.fury.io/rb/sys-proctree)
[![Dependency Status](https://gemnasium.com/MYOB-Technology/sys-proctree.png)](https://gemnasium.com/MYOB-Technology/sys-proctree)

Guide
-----

* gem install sys-proctree

```ruby
    require 'sys/proctree'

    ::Sys::ProcTree.find(2134) # Returns an array containing pids of the process tree whose root has pid 2134, children first

    ::Process.kill_tree(9, 2134) # Kills all processes in the tree of pid 2134 using kill signal 9
```

Dependencies
------------

Uses sys-proctable to discover process trees.  See sys-proctable for supported operating systems.

Requirements
------------

* Ruby >= 2.3
