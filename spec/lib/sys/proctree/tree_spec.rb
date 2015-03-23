describe ::Sys::ProcTree::Tree do

  let(:tree) { ::Sys::ProcTree::Tree }

  describe "#find" do

    before(:example) { allow(::Sys::ProcTree::ProcessStatusList).to receive(:new).and_return(process_status_list) }

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

      before(:example) { allow(process_status_list).to receive(:exists?).with(pid).and_return(true) }

      describe "when the tree is more than one level deep" do

        describe "with one process on each level" do

          let(:pid) { 1 }

          it "returns an array representing the tree in order from child first to parent last" do
            expect(tree.find(pid)).to eql([3, 2, 1])
          end

        end

        describe "with multiple processes on a level" do

          let(:pid) { 6 }

          it "returns an array containing processes order from child to parent, then as they appear in the underlying process table" do
            expect(tree.find(pid)).to eql([5, 7, 8, 6])
          end

        end

      end

    end

    describe "when the provided process does not exist" do

      before(:example) { allow(process_status_list).to receive(:exists?).and_return(false) }

      it "returns an empty array" do
        expect(tree.find(0)).to be_empty
      end

    end

    def create_proc_table_entries(options_array)
      options_array.map { |options| double("ProcTableStruct", options) }
    end

  end

end
