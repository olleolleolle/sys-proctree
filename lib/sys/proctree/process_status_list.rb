module Sys
  module ProcTree

    class ProcessStatusList < Array

      def initialize
        super(::Sys::ProcTable.ps)
      end

      def exists?(pid)
        !!find { |proc| proc.pid == pid }
      end

    end

  end
end
