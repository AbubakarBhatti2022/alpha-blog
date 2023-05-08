class AddTestingAtToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :testing_at, :datetime
  end
end
