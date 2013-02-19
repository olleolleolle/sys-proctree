module Sys
  module ProcTree

    module Process

      def kill_tree(pid)
        pids = ::Sys::ProcTree::Tree.find(pid)
        pids.collect do |pid|
          begin
            ::Process.kill(9, pid)
            ::Process.wait(pid)
          rescue => exc
            [pid, nil]
          end
        end
      end

    end

  end
end
