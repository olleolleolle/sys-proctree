describe ::Sys::ProcTree::Process do

  class TestableProcess
    extend Sys::ProcTree::Process
  end

  describe "#kill_tree" do

    let(:kill_signal) { 7 }
    let(:tree_pids) { [2, 6, 8] }

    before(:example) do
      allow(::Sys::ProcTree::Tree).to receive(:find).and_return([2, 6, 8])
      allow(::Process).to receive(:kill)
      allow(::Process).to receive(:wait)
    end

    it "discovers the pids of the process tree" do
      expect(::Sys::ProcTree::Tree).to receive(:find).with(8).and_return(tree_pids)

      TestableProcess.kill_tree(kill_signal, 8)
    end

    it "attempts to kill each process with the provided kill signal in tree order" do
      tree_pids.each { |pid| expect(::Process).to receive(:kill).with(kill_signal, pid) }

      TestableProcess.kill_tree(kill_signal, 8)
    end


    it "waits for all processes to complete" do
      tree_pids.each { |pid| expect(::Process).to receive(:wait).with(pid) }

      TestableProcess.kill_tree(kill_signal, 8)
    end

    it "returns the exit status of all killed processes" do
      wait_results = tree_pids.map do |pid|
        [ pid, double(::Process::Status) ].tap do |result|
          allow(::Process).to receive(:wait).with(pid).and_return(result)
        end
      end

      expect(TestableProcess.kill_tree(kill_signal, 8)).to eql(wait_results)
    end

    describe "when a process has already been killed" do

      let(:kill_signal) { 9 }

      before(:example) { allow(::Process).to receive(:kill).with(kill_signal, 6).and_raise("No such process") }

      it "continues to kill subsequent processes" do
        [2, 8].each { |pid| expect(::Process).to receive(:kill).with(kill_signal, pid) }

        TestableProcess.kill_tree(kill_signal, 8)
      end

      it "returns an exit status of nil" do
        wait_results = [[2, double(::Process::Status)], [6, nil], [8, double(::Process::Status)]]
        allow(::Process).to receive(:wait).with(2).and_return(wait_results[0])
        allow(::Process).to receive(:wait).with(8).and_return(wait_results[2])

        expect(TestableProcess.kill_tree(kill_signal, 8)).to eql(wait_results)
      end

    end

  end

end
