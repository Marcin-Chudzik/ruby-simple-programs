# frozen_string_literal: true

require 'csv'

class CSVImport
  attr_reader :configuration

  def initialize
    @configuration = CSVImportConfiguration.new
  end

  def self.from_file(filepath)
    import = new
    yield import.configuration
    rows = CSV.read(filepath, col_sep: ';')
    import.process(rows)
  end

  def process(rows)
    rows.map { |row| process_row(row) }
  end

  private

  def process_row(row)
    obj = {}
    @configuration.columns.each do |col|
      obj[col.name] = col.type.call(row[col.col_number - 1])
    end
    obj
  end
end

class CSVImportConfiguration
  attr_reader :columns

  Column = Struct.new(:name, :col_number, :type)

  def initialize
    @columns = []
  end

  def string(name, column:)
    @columns << Column.new(name, column, ->(x) { x.to_s })
  end

  def integer(name, column:)
    @columns << Column.new(name, column, ->(x) { x.to_i })
  end

  def decimal(name, column:)
    @columns << Column.new(name, column, ->(x) { x.to_f })
  end
end

records = CSVImport.from_file('top10movies.csv') do |config|
  config.string :title, column: 1
  config.integer :year, column: 2
  config.decimal :rating, column: 3
  config.string :score, column: 4
end

puts records
