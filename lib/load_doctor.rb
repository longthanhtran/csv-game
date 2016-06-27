require 'csv'

module CsvReader
  def CsvReader::read_csv(filename)
    CSV.foreach(filename) do |row|
      puts "#{row[0]}" if row.length > 41
    end
  end

  def CsvReader::get_csv_header(filename)
    header = File.open(filename, 'rb').readline
  end

  def CsvReader::to_underscore_name(name)
    name.downcase.gsub(" ", "_")
  end

  def CsvReader::create_table(array)
    # for each col, call CsvReader::to_underscore_name
    # create sql create table query
    # excute query
    array.each do |item|
      CsvReader::to_underscore_name(item)

    end
  end
end
