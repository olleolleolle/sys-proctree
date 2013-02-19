describe ::Sys::ProcTree::Tree do

  let(:tree) { ::Sys::ProcTree::Tree }

  describe "#find" do

    before(:each) do
      ::Sys::ProcTree::ProcessStatusList.should_receive(:new).and_return(process_status_list)
    end

    let(:process_status_list) do
      create_proc_table_entries([{ pid: 2, ppid: 1 },
                                 { pid: 1, ppid: nil },
                                 { pid: 3, ppid: 2 },
                                 { pid: 4, ppid: nil },
                                 { pid: 5, ppid: 6 },
                                 { pid: 6, ppid: nil },
                                 { pid: 7, ppid: 6 },
                                 { pid: 8, ppid: 6 }])
    end

    describe "when the provided process exists" do

      before(:each) { process_status_list.stub!(:exists?).with(pid).and_return(true) }

      describe "when the tree is more than one level deep" do

        describe "with one process on each level" do

          let(:pid) { 1 }

          it "should return an array representing the tree in order from child first to parent last" do
            tree.find(pid).should eql([3, 2, 1])
          end

        end

        describe "with multiple processes on a level" do

          let(:pid) { 6 }

          it "should return an array containing processes order from child to parent, then as they appear in the underlying process table" do
            tree.find(pid).should eql([5, 7, 8, 6])
          end

        end

      end

    end

    describe "when the provided process does not exist" do

      before(:each) { process_status_list.stub!(:exists?).and_return(false) }

      it "should return an empty array" do
        tree.find(0).should be_empty
      end

    end

    def create_proc_table_entries(options_array)
      options_array.map { |options| double("ProcTableStruct", options) }
    end

  end

end
