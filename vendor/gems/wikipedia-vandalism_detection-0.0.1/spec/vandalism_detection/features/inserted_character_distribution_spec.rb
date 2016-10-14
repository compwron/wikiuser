require 'spec_helper'

describe Wikipedia::VandalismDetection::Features::InsertedCharacterDistribution do

  before do
    @feature = Wikipedia::VandalismDetection::Features::InsertedCharacterDistribution.new
  end

  it { should be_a Wikipedia::VandalismDetection::Features::Base }

  describe "#calculate" do

    it "returns the Kullback-Leibler Divergence of the inserted text's character distribution" do
      old_text = Wikipedia::VandalismDetection::Text.new('old text')
      new_text = Wikipedia::VandalismDetection::Text.new 'old text [[new inserted text]] given dero 9'

      old_revision = build(:old_revision, text: old_text)
      new_revision = build(:new_revision, text: new_text)
      edit = build(:edit, old_revision: old_revision, new_revision: new_revision)

      expect(@feature.calculate(edit)).to eq 1.6609633564650683
    end

    it "returns missing value if no alphanumeric characters are inserted" do
      old_text = Wikipedia::VandalismDetection::Text.new("old text")
      new_text = Wikipedia::VandalismDetection::Text.new("old text !* [[?]]")

      old_revision = build(:old_revision, text: old_text)
      new_revision = build(:new_revision, text: new_text)
      edit = build(:edit, new_revision: new_revision, old_revision: old_revision)

      expect(@feature.calculate(edit)).to eq Wikipedia::VandalismDetection::Features::MISSING_VALUE
    end

    it "returns missing value if no text inserted" do
      old_text = Wikipedia::VandalismDetection::Text.new("deletion text")
      new_text = Wikipedia::VandalismDetection::Text.new("text")

      old_revision = build(:old_revision, text: old_text)
      new_revision = build(:new_revision, text: new_text)
      edit = build(:edit, new_revision: new_revision, old_revision: old_revision)

      expect(@feature.calculate(edit)).to eq Wikipedia::VandalismDetection::Features::MISSING_VALUE
    end
  end
end