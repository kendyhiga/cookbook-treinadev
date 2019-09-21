# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cuisine, type: :model do
  it { is_expected.to have_db_column(:name).of_type(:string) }
end
