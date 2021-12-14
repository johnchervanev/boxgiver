class AddReceivedReviewsCountToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :received_reviews_count, :integer, default: 0
  end
end
