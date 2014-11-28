class Comparator

  def initialize(first, second)
    @first  = first
    @second = second
  end

  def compare
    first_file  = set_words(@first)
    second_file = set_words(@second)

    mixed  = first_file | second_file
    equals = first_file & second_file
    words = []

    mixed.each_with_index do | v, i |
      if (equals.include? first_file[i])
        v1 = first_file[i]
        v2 = first_file[i]
      else
        v1 = (equals.include? first_file[i])  ? nil : first_file[i]
        v2 = (equals.include? second_file[i]) ? nil : second_file[i]
      end
      words << [v1, v2] unless v1.nil? && v2.nil?
    end

    print_coincidences(calc_diff(words))
  end

  private

  def set_words(file_path)
    raise 'Invalid path' if file_path.empty?
    return File.readlines(file_path).each { |val| val.delete!("\n") }
  end

  def calc_diff(words)
    values  = []
    words.each_with_index do | value, index |
      values << index + 1
      if value[0] == value[1]
        values << ' '
        values << value[0]
      elsif value[0].nil?
        values << '+'
        values << value[1]
      elsif value[1].nil?
        values << '-'
        values << value[0]
      elsif value[0] != value[1]
        values << '*'
        values << "#{ value[0] } | #{ value[1] }"
      end
    end
    return values
  end

  def print_coincidences(diff)
    diff.each_with_index do | value, index |
      print ((index + 1) % 3 == 0) ? "#{ value }\n" : "#{ value } "
    end
  end

end
