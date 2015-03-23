module Sys
  module ProcTree

    class Tree

      class << self

        def find(pid)
          self.new(pid).pids
        end

      end

      def initialize(pid)
        @pid = pid
      end

      def pids
        process_status_list.exists?(@pid) ? with_children([@pid]) : []
      end

      private

      def with_children(pids)
        child_pids = process_status_list.map do |proc|
          pids.include?(proc.ppid) ? proc.pid : nil
        end.compact
        child_pids.empty? ? pids : with_children(child_pids) + pids
      end

      def process_status_list
        @process_status_list ||= ::Sys::ProcTree::ProcessStatusList.new
      end

    end

  end
end
