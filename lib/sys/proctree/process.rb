module Sys
  module ProcTree

    module Process

      def kill_tree(signal, pid)
        pids_in_tree = ::Sys::ProcTree::Tree.find(pid)
        pids_in_tree.map do |pid_in_tree|
          begin
            ::Process.kill(signal, pid_in_tree)
            ::Process.wait(pid_in_tree)
          rescue StandardError
            [ pid_in_tree, nil ]
          end
        end
      end

    end

  end
end
