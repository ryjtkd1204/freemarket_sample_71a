class RemovebirthYearFromProfiles < ActiveRecord::Migration[5.2]
  def change
    remove_column :Profiles, :birth_year
    remove_column :Profiles, :birth_month
    remove_column :Profiles, :birth_day
  end
end
