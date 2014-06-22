class CreateUsersAndVersions < ActiveRecord::Migration
  
  def change

    # HStore --------------------------------------------------------

    if Rails.env.development? || Rails.env.test?
      # this is done via recipes on staging and production
      execute "CREATE EXTENSION IF NOT EXISTS hstore"
    end

    # Devise --------------------------------------------------------

    create_table :users do |t|

      t.string :status,             null: false, default: '' 

      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      ## Encryptable
      t.string :password_salt,      null: false, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.timestamps

    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true

    # Paper Trail ---------------------------------------------------

    create_table :versions do |t|

      t.string   :item_type, :null => false
      t.integer  :item_id,   :null => false
      t.string   :event,     :null => false
      t.string   :whodunnit
      t.text     :object
      t.datetime :created_at

    end

    add_index :versions, [:item_type, :item_id]

    # ---------------------------------------------------------------

  end
end
