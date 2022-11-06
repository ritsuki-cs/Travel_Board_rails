class AddAddressToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :address, :string
    add_column :microposts, :lat, :float
    add_column :microposts, :lng, :float
  end
end
