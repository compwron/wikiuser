require 'spec_helper'

describe Wikipedia::VandalismDetection::Features::BadFrequency do

  before do
    @feature = Wikipedia::VandalismDetection::Features::BadFrequency.new
  end

  it { should be_a Wikipedia::VandalismDetection::Features::FrequencyBase }

  describe "#calculate" do

    it "returns the number of vulgarism words relative to all words count" do
      # total 6 words, 3 bad
      old_text = Wikipedia::VandalismDetection::Text.new 'Old whatever.'
      new_text = Wikipedia::VandalismDetection::Text.new "Old whatever. New ugly contents. Hi, gotta fun."

      old_revision = build(:old_revision, text: old_text)
      new_revision = build(:new_revision, text: new_text)
      edit = build(:edit, old_revision: old_revision, new_revision: new_revision)

      expect(@feature.calculate(edit)).to eq 3.0 / 6.0
    end

    it "returns 0.0 on emtpy clean text revisions" do
      old_text = Wikipedia::VandalismDetection::Text.new 'Old guy.'
      new_text = Wikipedia::VandalismDetection::Text.new "Old guy. {{speedy deletion}}"

      old_revision = build(:old_revision, text: old_text)
      new_revision = build(:new_revision, text: new_text)
      edit = build(:edit, old_revision: old_revision, new_revision: new_revision)

      expect(@feature.calculate(edit)).to eq 0.0
    end
  end
end