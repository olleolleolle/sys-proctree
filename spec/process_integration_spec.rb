describe ::Process, "integrating with real processes" do

  RESOURCE_DIR = File.expand_path("../resources", __FILE__)

  FIVE_SECONDS = 5

  describe "#kill_tree" do

    describe "when one process is running" do

      let(:pid) { ::Process.spawn("irb") }

      it "should kill the process" do
        ::Process.kill_tree(9, pid)

        wait_until_killed([pid])
      end

    end

    describe "when multiple processes are running" do

      let(:ppid) { start_multiple_processes }

      before(:each) do
        wait_until_true("process tree has started") { ::Sys::ProcTree::Tree.find(ppid).length == 3 }
      end

      it "should kill all processes in the tree" do
        tree_pids = ::Sys::ProcTree::Tree.find(ppid)

        ::Process.kill_tree(9, ppid)

        wait_until_killed(tree_pids)
      end

    end

  end

  def start_multiple_processes
    ::Process.spawn("#{RESOURCE_DIR}/start_parent.#{::OS.windows? ? "bat" : "sh"}")
  end

  def wait_until_killed(pids)
    wait_until_true("processes #{pids.join(", ")} have been killed") do
      process_statuses = ::Sys::ProcTree::ProcessStatusList.new
      pids.reduce(true) { |all_killed_flag, pid| all_killed_flag && !process_statuses.exists?(pid) }
    end
  end

  def wait_until_true(description, &block)
    start_time = Time.now
    while true
      begin
        return if block.call
      rescue
        # Intentionally blank
      end
      raise "Timed-out waiting until '#{description}'" if Time.now - start_time > FIVE_SECONDS
    end
  end

end
