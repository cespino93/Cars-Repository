class AddIndexToPosts < ActiveRecord::Migration[6.1]
    def change
      add_index :posts, :title
    end
  end