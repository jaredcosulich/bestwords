class AddWords < ActiveRecord::Migration
  def self.up
    create_table :words do |t|
      t.integer   :user_id
      t.string    :ip
      t.string    :word
      t.integer   :points

      t.timestamps
    end

    change_table :users do |t|
      t.text      :suggested_words
    end

    add_index :words, :user_id
  end

  def self.down
    drop_table :words
    change_table :users do |t|
      t.remove    :suggested_words
    end
  end
end
