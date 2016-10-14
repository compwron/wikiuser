require 'spec_helper'

describe Wikipedia::VandalismDetection::Features::ContainsBase do

  before do
    @base = Wikipedia::VandalismDetection::Features::ContainsBase.new
  end

  it { should be_a Wikipedia::VandalismDetection::Features::Base }

  describe "#contains" do

    it "returns 1 if a given text contains the given terms array" do
      text = "Content including text"
      expect(@base.contains(text, ['content', 'anything'])).to eq 1
    end

    it "returns 1 if a given text contains the given string" do
      text = "Content including text"
      expect(@base.contains(text, 'content')).to eq 1
    end

    it "returns 0 if a given text does not contain the given string" do
      text = "not containing anything con tent"
      expect(@base.contains(text, 'content')).to eq 0
    end

    it "returns 0 if a given text does not contain any of the given terms" do
      text = "not containing anything con tent"
      expect(@base.contains(text, ['content', 'text'])).to eq 0
    end
  end
end