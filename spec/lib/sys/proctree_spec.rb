describe ::Sys::ProcTree do

  describe "#find" do

    it "finds a tree via a Sys::ProcTree::Tree" do
      allow(::Sys::ProcTree::Tree).to receive(:find).with(7).and_return([1, 3, 7])

      expect(::Sys::ProcTree.find(7)).to eql([1, 3, 7])
    end

  end

end
