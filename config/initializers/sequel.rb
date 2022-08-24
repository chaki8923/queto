require "sequel"
DB = Sequel.postgres(extensions: :activerecord_connection) # postgres