describe Ping do
  it "pings" do
    expect(Ping.new.ping).to eq("pong")
  end
end
