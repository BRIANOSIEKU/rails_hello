class AddLikedUserIdsToFacts < ActiveRecord::Migration[7.1]
  def change
    add_column :facts, :liked_user_ids, :text
  end
end
