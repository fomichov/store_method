require File.expand_path('../../spec_helper', __FILE__)

describe "StoreMethod" do
  context "new record" do
    let(:user) { User.new }
    it "should actually call the process method once" do
      expect(user).to receive(:process).and_return("JohnJohn").once
      2.times { expect(user.name).to eq("JohnJohn") }
    end

    it "should create _orig method" do
      expect(user.name_orig).to eq("JohnJohn")
    end

    it "should support refresh method" do
      expect(user.name).to eq("JohnJohn")
      expect(user).to receive(:process).and_return("AdamAdam")
      expect(user.refresh_name).to eq("AdamAdam")
      expect(user.attributes["name"]).to eq("AdamAdam")
    end

    it "should pass attributes" do
      expect(user.name).to eq("JohnJohn")
      expect(user.name("Adam")).to eq("AdamAdam")
      expect(user.attributes["name"]).to eq("JohnJohn")
    end

    it "should save valid record" do
      expect(user.name).to eq("JohnJohn") 
      expect { user.save }.to change{User.count}.by(1)
      expect(user.read_attribute(:name)).to eq("JohnJohn")
    end
  end

  context "existing record" do
    before(:each) do
      @user = User.create!
    end

    it "should actually call the process method once" do
      expect(@user).to receive(:process).and_return("JohnJohn").once
      2.times { expect(@user.name).to eq("JohnJohn") }
    end

    it "should create _orig method" do
      expect(@user.name_orig).to eq("JohnJohn")
    end

    it "should support refresh method" do
      expect(@user.name).to eq("JohnJohn")
      expect(@user).to receive(:process).and_return("AdamAdam")
      expect(@user.refresh_name).to eq("AdamAdam")
      expect(@user.attributes["name"]).to eq("AdamAdam")
    end

    it "should pass attributes" do
      expect(@user.name).to eq("JohnJohn")
      expect(@user.name("Adam")).to eq("AdamAdam")
      expect(@user.attributes["name"]).to eq("JohnJohn")
    end
  end
end
