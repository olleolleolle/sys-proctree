describe ::Sys::ProcTree::ProcessStatusList do

  before(:example) { allow(::Sys::ProcTable).to receive(:ps).and_return(proc_list) }

  let(:proc_list) do
    [double("ProcTableStruct", pid: 1, ppid: 2),
     double("ProcTableStruct", pid: 2, ppid: 3),
     double("ProcTableStruct", pid: 3, ppid: nil)]
  end

  let(:list) { ::Sys::ProcTree::ProcessStatusList.new }

  it "should be an array" do
    expect(list).to be_an(Array)
  end

  it "should contain proc table process status results" do
    expect(::Sys::ProcTable).to receive(:ps).and_return(proc_list)

    expect(list).to eql(proc_list)
  end

  describe "exists?" do

    describe "when the process exists" do

      let(:pid) { 2 }

      it "should return true" do
        expect(list.exists?(pid)).to be(true)
      end

    end

    describe "when the process does not exist" do

      let(:pid) { -1 }

      it "should return false" do
        expect(list.exists?(pid)).to be(false)
      end

    end

  end

end
