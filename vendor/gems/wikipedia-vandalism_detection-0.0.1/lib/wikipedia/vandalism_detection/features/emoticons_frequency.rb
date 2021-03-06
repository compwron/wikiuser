require 'wikipedia/vandalism_detection/features/base'
require 'wikipedia/vandalism_detection/word_lists/emoticons'

module Wikipedia
  module VandalismDetection
    module Features

      # This feature computes frequency of emoticon words in the inserted text.
      class EmoticonsFrequency < Base

        # Returns the percentage of emoticon words in the inserted text.
        # Returns 0.0 if inserted clean text is of zero length.
        def calculate(edit)
          super

          inserted_text = edit.inserted_text
          regex = /(^|\s)(#{WordLists::EMOTICONS.join('|')})(?=\s|$|\Z|[\.,!?]\s|[\.!?]\Z)/

          emoticons_count = inserted_text.scan(regex).flatten.reject { |c| c.size < 2 }.count
          total_count = inserted_text.split.count

          (total_count > 0) ? (emoticons_count.to_f) / (total_count.to_f) : 0.0
        end
      end
    end
  end
end