describe ::Process do

  it "has the ability to kill a process tree" do
    expect(::Process).to be_a(::Sys::ProcTree::Process)
  end

end
