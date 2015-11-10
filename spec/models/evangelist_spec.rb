# == Schema Information
#
# Table name: evangelists
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  phone      :string(255)
#  note       :text
#

require 'spec_helper'

describe Evangelist do
  pending "add some examples to (or delete) #{__FILE__}"
end
