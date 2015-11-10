# == Schema Information
#
# Table name: loves
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  loved_id   :integer
#  lover_id   :integer
#

require 'spec_helper'

describe Love do
  pending "add some examples to (or delete) #{__FILE__}"
end
