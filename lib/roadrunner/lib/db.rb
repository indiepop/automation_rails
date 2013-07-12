
module RoadRunnerModule

  module Dbhelper

    def migrate(tables)
      tables.each do |table|
        case table
          when "scenarios"  then
            unless ActiveRecord::Base.connection.tables.include?(table.to_s) then
              ActiveRecord::Base.connection.create_table(table.to_sym) do |t|
                t.column :name, :string
                t.column :create_at,:string
                t.column :script, :string
                t.column :author, :string, :default => 'Anonymous'
                t.column :author, :string
                t.column :tps, :int
                t.column :desc, :string
              end
            end

          when "transactions"  then
            unless ActiveRecord::Base.connection.tables.include?(table.to_s) then
              ActiveRecord::Base.connection.create_table(table.to_sym) do |t|
                t.column :name,:string,:limit => 256
                t.column :scenario_id,:string,:limit => 256
                t.column :success_rate,:string, :limit => 8
                t.column :create_at,:string, :limit => 32

              end
            end

          when "records"  then
            unless ActiveRecord::Base.connection.tables.include?(table.to_s) then
              ActiveRecord::Base.connection.create_table(table.to_sym) do |t|
                t.column :cost, :string, :limit => 32
                t.column :ts, :string, :limit => 32
                t.column :seq, :int
                t.column :stats,:int
                t.column :transaction_id,:string,:limit => 256
                t.column :create_at,:string, :limit => 32
              end
            end
        end
      end
    end

    module_function :migrate
  end

end
