describe ::Sys::ProcTree::Process do

  class TestableProcess
    extend Sys::ProcTree::Process
  end

  describe "#kill_tree" do

    let(:kill_signal) { 7 }
    let(:tree_pids) { [2, 6, 8] }

    before(:each) do
      ::Sys::ProcTree::Tree.stub(:find).and_return([2, 6, 8])
      ::Process.stub(:kill)
      ::Process.stub(:wait)
    end

    it "should discover the pids of the process tree" do
      ::Sys::ProcTree::Tree.should_receive(:find).with(8).and_return(tree_pids)

      TestableProcess.kill_tree(kill_signal, 8)
    end

    it "should attempt to kill each process with the provided kill signal in tree order" do
      tree_pids.each { |pid| ::Process.should_receive(:kill).with(kill_signal, pid) }

      TestableProcess.kill_tree(kill_signal, 8)
    end


    it "should wait for all processes to complete" do
      tree_pids.each { |pid| ::Process.should_receive(:wait).with(pid) }

      TestableProcess.kill_tree(kill_signal, 8)
    end

    it "should return the exit status of all killed processes" do
      wait_results = tree_pids.map do |pid|
        [pid, double(Process::Status)].tap { |result| ::Process.stub(:wait).with(pid).and_return(result) }
      end

      TestableProcess.kill_tree(kill_signal, 8).should eql(wait_results)
    end

    describe "when a process has already been killed" do

      let(:kill_signal) { 9 }

      before(:each) { ::Process.stub(:kill).with(kill_signal, 6).and_raise("No such process") }

      it "should continue to kill subsequent processes" do
        [2, 8].each { |pid| ::Process.should_receive(:kill).with(kill_signal, pid) }

        TestableProcess.kill_tree(kill_signal, 8)
      end

      it "should return an exit status of nil" do
        wait_results = [[2, double(Process::Status)], [6, nil], [8, double(Process::Status)]]
        ::Process.stub(:wait).with(2).and_return(wait_results[0])
        ::Process.stub(:wait).with(8).and_return(wait_results[2])

        TestableProcess.kill_tree(kill_signal, 8).should eql(wait_results)
      end

    end

  end

end
