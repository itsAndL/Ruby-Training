# this is a Migration file
# is responsible for creating the post
# database table, which will store data
# for your post object

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title

      t.timestamps
    end
  end
end
