describe ::Process do

  it "should have the capability to kill a process tree" do
    ::Process.should be_a(::Sys::ProcTree::Process)
  end

end
