class CreateFacts < ActiveRecord::Migration[7.0]
  def change
    unless table_exists?(:facts)
      create_table :facts do |t|
        t.string :title
        t.text :content

        t.timestamps
      end
    end
  end
end
