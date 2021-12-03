# == Schema Information
#
# Table name: blogs
#
#  id                 :bigint           not null, primary key
#  community_id       :integer
#  author_id          :string(255)
#  title              :string(255)
#  content            :text(65535)
#  image              :string(255)
#  slug               :string(255)
#  published          :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  minutes            :decimal(10, )
#

require 'rails_helper'

RSpec.describe Blog, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
