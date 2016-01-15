class CreateUsers < ActiveRecord::Migration
  def up
    #enum created but not used in code
    execute <<-SQL
      CREATE TYPE login_type AS ENUM ('social', 'web', 'mobile');
    SQL
    create_table :users do |t|
      t.string  :email, null: false
      t.string  :password, null: false
      t.string  :registration_type, null: false
      t.timestamps
    end
  end

  def down
    drop_table :users
    #enum created but not used in code
    execute <<-SQL
      DROP TYPE login_type;
    SQL
  end

end
