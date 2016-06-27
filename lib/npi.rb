require 'csv'

class NPI
  attr_reader :header, :field

  def initialize(filename)
    @header = File.open(filename, 'rb').readline.gsub("\n", "").split(",")
    @csv_fhandler = CSV.open(filename)
  end

  def get_address
    result = []
    @header.each do |item|
      result << item if item.include?("Address")
    end
    result
  end

  def get_doctor
    result = []
    @header.each do |item|
      result << item if !item.include?("Address")
    end
    result
  end

  def field_mapper
    result = []
    @header.each do |item|
      result << ( item.include?("Address") ? /(\w+ Address)/.match(item)[0] : "Doctor" )
    end
    @field = result
  end

  def table_type
    field_mapper
    @field.uniq
  end

  def header_map
    field_mapper
    Hash[(0..@field.size - 1).zip @field]
  end

  def get_row(number = 1)
    count = 0
    @csv_fhandler.readline
    @csv_fhandler.each do |line|
      return if count >= number
      tmp = extract_row(line)
      yield(tmp) if block_given?
      count += 1
    end
  end

  def extract_row(row)
    result = []
    types = table_type # [ "Doctor", "Business Address", "Mailing Address" ]
    map = header_map # { 0 => "Doctor", 1 => "Doctor", .. }
    types.each do |item|
      tmp = []
      map.each do |k, v|
        tmp << row[k] if item == v
      end
      result << tmp
    end
    result
  end
end
