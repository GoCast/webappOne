class AddRtspUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rtsp_url, :string
  end
end
