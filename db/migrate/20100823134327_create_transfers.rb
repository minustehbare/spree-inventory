class CreateTransfers < ActiveRecord::Migration
  def self.up
    create_table :transfers do |t|
      t.column :source_id, :integer
      t.column :destination_id, :integer
      t.column :count, :integer
      t.column :received_at, :date
      t.timestamps
    end
  end

  def self.down
    drop_table :transfers
  end
end
