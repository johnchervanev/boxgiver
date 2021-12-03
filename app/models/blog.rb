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

class Blog < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage/
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]

  belongs_to :author, class_name: "Person", foreign_key: :author_id

  def avatar_thumb
    return "" if self.author.nil?
    self.author.image.present? ? self.author.image.url(:small) : ActionController::Base.helpers.asset_path("profile_image/small/missing.png")
  end
end
