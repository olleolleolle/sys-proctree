describe ::Sys::ProcTree::ProcessStatusList do

  before(:each) { ::Sys::ProcTable.stub(:ps).and_return(proc_list) }

  let(:proc_list) do
    [double("ProcTableStruct", pid: 1, ppid: 2),
     double("ProcTableStruct", pid: 2, ppid: 3),
     double("ProcTableStruct", pid: 3, ppid: nil)]
  end

  let(:list) { ::Sys::ProcTree::ProcessStatusList.new }

  it "should be an array" do
    list.should be_an(Array)
  end

  it "should contain proc table process status results" do
    ::Sys::ProcTable.should_receive(:ps).and_return(proc_list)

    list.should eql(proc_list)
  end

  describe "exists?" do

    describe "when the process exists" do

      let(:pid) { 2 }

      it "should return true" do
        list.exists?(pid).should be_true
      end

    end

    describe "when the process does not exist" do

      let(:pid) { -1 }

      it "should return false" do
        list.exists?(pid).should be_false
      end

    end

  end

end
