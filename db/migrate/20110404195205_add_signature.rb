class AddSignature < ActiveRecord::Migration
  def self.up
    add_column :user_words, :signature, :string
  end

  def self.down
    remove_column :user_words, :signature, :string
  end
end
