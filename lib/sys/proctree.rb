require 'sys/proctable'

require_relative "proctree/process_status_list"
require_relative "proctree/tree"
require_relative "proctree/process"

::Process.extend(::Sys::ProcTree::Process)

module Sys

  module ProcTree

    def self.find(pid)
      ::Sys::ProcTree::Tree.find(pid)
    end

  end

end
