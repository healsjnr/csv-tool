require 'csv'


class CsvTool
  include Enumerable

  attr_accessor :data, :headers


  def initialize(data_file)
    @data_file = data_file
    @headers = Array.new
    @data = Array.new
    CSV.read(data_file, :encoding => 'windows-1252:utf-8').first.each do |h|
      @headers << h.strip.to_sym
    end

    row_count = 0
    CSV.foreach(data_file, :encoding => 'windows-1252:utf-8') do |row|
      row_count += 1
      next if row_count == 1 
      row_data = Hash.new
      row.each_with_index do |c, i|
        row_data[@headers[i]] = c.strip
      end
      @data << row_data

    end
  end
  
  def each &blk
    @data.each &blk
  end

  def columns *args
   values = @data.map do |d|
     output = Hash.new
     args.each do |p|
       output[p] = d[p]
     end
     output
   end
   values
  end

 
end

