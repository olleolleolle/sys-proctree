describe ::Sys::ProcTree do

  describe "#find" do

    it "should find a tree via a Sys::ProcTree::Tree" do
      ::Sys::ProcTree::Tree.should_receive(:find).with(7).and_return([1, 3, 7])

      ::Sys::ProcTree.find(7).should eql([1, 3, 7])
    end

  end

end
