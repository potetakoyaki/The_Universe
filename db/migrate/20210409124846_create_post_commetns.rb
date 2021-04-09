class CreatePostCommetns < ActiveRecord::Migration[5.2]
  def change
    create_table :post_commetns do |t|

      t.timestamps
    end
  end
end
