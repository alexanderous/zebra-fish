# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :text
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  draft      :boolean
#  user_id    :integer
#  image      :string(255)
#

require 'spec_helper'

describe Article do
  pending "add some examples to (or delete) #{__FILE__}"
end
