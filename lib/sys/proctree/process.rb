module Sys
  module ProcTree

    module Process

      def kill_tree(signal, pid)
        pids = ::Sys::ProcTree::Tree.find(pid)
        pids.collect do |pid|
          begin
            ::Process.kill(signal, pid)
            ::Process.wait(pid)
          rescue
            [pid, nil]
          end
        end
      end

    end

  end
end
