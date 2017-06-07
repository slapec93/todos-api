require 'rails_helper'

# Test suite for Todo model
RSpec.describe Todo, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
end
