require 'rails_helper'

RSpec.describe ClassGroup, :type => :model do
  
  describe 'Class Group' do
    it 'creates a valid class group' do
      valid_class = ClassGroup.create(
        name: "Cohort 8",
        description: "The Ocho"
        )
      expect(valid_class).to be_valid
    end

    it 'is invalid without a name' do
      invalid_class = ClassGroup.create(
        name: "",
        description: "The Ocho"
        )
      expect(invalid_class).to be_invalid
    end

    it 'is invalid without a description' do
      invalid_class = ClassGroup.create(
        name: "Cohort 8",
        description: ""
        )
      expect(invalid_class).to be_invalid
    end
  end
end
