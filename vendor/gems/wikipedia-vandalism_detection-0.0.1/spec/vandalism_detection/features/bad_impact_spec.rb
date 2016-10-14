require 'spec_helper'

describe Wikipedia::VandalismDetection::Features::BadImpact do

  before do
    @feature = Wikipedia::VandalismDetection::Features::BadImpact.new
  end

  it { should be_a Wikipedia::VandalismDetection::Features::ImpactBase }

  describe "#calculate" do

    it "returns the impact of bad words of the edit's new revision text" do
      # 3 bad words
      old_text = Wikipedia::VandalismDetection::Text.new "Hi, old text 666, dont know"

      # 4 bad words
      new_text = Wikipedia::VandalismDetection::Text.new "Hi, new text dosent, whatever, guy"

      old_revision = build(:old_revision, text: old_text)
      new_revision = build(:new_revision, text: new_text)
      edit = build(:edit, old_revision: old_revision, new_revision: new_revision)

      expect(@feature.calculate(edit)).to eq 3.0 / (3.0 + 4.0)
    end

    it "returns 0.5 on both no terms in text revisions" do
      text = Wikipedia::VandalismDetection::Text.new "{{speedy deletion}}"

      old_revision = build(:old_revision, text: text)
      new_revision = build(:new_revision, text: text)
      edit = build(:edit, new_revision: new_revision, old_revision: old_revision)

      expect(@feature.calculate(edit)).to eq 0.5
    end

    it "returns 0.0 on emtpy clean text of old revision" do
      old_text = Wikipedia::VandalismDetection::Text.new "{{speedy deletion}}"
      new_text = Wikipedia::VandalismDetection::Text.new "Guy"

      old_revision = build(:old_revision, text: old_text)
      new_revision = build(:new_revision, text: new_text)
      edit = build(:edit, new_revision: new_revision, old_revision: old_revision)

      expect(@feature.calculate(edit)).to eq 0.0
    end

    it "returns 1.0 on emtpy clean text of new revision" do
      old_text = Wikipedia::VandalismDetection::Text.new "Guy"
      new_text = Wikipedia::VandalismDetection::Text.new "{{speedy deletion}}"

      old_revision = build(:old_revision, text: old_text)
      new_revision = build(:new_revision, text: new_text)
      edit = build(:edit, new_revision: new_revision, old_revision: old_revision)

      expect(@feature.calculate(edit)).to eq 1.0
    end
  end
end