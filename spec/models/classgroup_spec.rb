require 'rails_helper'

RSpec.describe ClassGroup, :type => :model do
  
  describe 'Class Group' do
    it 'creates a valid class group' do
      valid_class = Fabricate(:class_group)
      expect(valid_class).to be_valid
    end

    it 'is invalid without a name' do
      invalid_class = ClassGroup.create(
        name: "",
        description: "The Ocho"
        )
      expect(invalid_class).to be_invalid
    end
  end
end
