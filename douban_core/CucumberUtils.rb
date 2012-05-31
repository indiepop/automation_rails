module WCF
  module Utils

    # Additional tools that can be useful dealing with Cucumber and Ruby.
    # @author Oleksii Matiiasevych, lastperson@gmail.com
    class CucumberUtils
      # Create advanced hash table from raw cucumber table input.
      # @param [Cucumber::Ast::Table.raw] table to process.
      # @example Build a Hash
      #   CucumberUtils.adv_hash([['a','a1'],['b','b1'],['','b2']]) #=> {'a' => ['a1'],'b' => ['b1','b2']}
      # @return [Hash] processed table.
      def self.adv_hash(rows)
        adv_hash = {}
        prev_name = ""
        rows.each do |item|
          if item[0].empty?
            adv_hash[prev_name] << item[1]
          else
            adv_hash[item[0]] = [item[1]]
            prev_name = item[0]
          end
        end
        adv_hash
      end

      # Beautify feature file data tables.
      # @note Changes entire file!
      # @param [String] filename to process.
      # @example Directory reformat
      #   Dir.glob(File.join("#{directory_path}","**","*.feature")).each {|filename| CucumberUtils.reformat_tables(filename)}
      # @return [Boolean] true if file processed OK and changed, and false if there is errors (file not changed).
      def self.reformat_tables(filename)
        def self.print_section(section)
          text = ""
          section = section.transpose
          section = [section[0]] + section[1..-1].map { |cols| cols.map { |item| item.strip } }
          lengths = section[1..-1].map { |cols| (cols.sort_by { |item| item.length }).last.length }
          section = section.transpose
          section.each do |row|
            text += row.shift + "|"
            row.each_index do |col_index|
              text += " #{row[col_index]}#{' ' * (lengths[col_index] - row[col_index].length)} |"
            end
            text += "\n"
          end
          text
        end

        print("#{filename}: ")
        file = open(filename, "r")
        new_file = ""
        section = []
        begin
          file.each do |line|
            if line =~ /^\s*\|(?:[^\|]*\|)+\s*$/
              section << line.rstrip.split("|")
            else
              if not section.empty?
                new_file += print_section(section)
                section = []
              end
              new_file += line
            end
          end
          if not section.empty?
            new_file += print_section(section).rstrip # if file ends with section, remove last \n
          end
        rescue IndexError
          print(": FAIL. Table above line ##{file.lineno} is corrupted. File is not changed.\n")
          file.close
          return false
        end
        file.reopen(filename, "w")
        file.print(new_file)
        file.close
        print(": OK\n")
        return true
      end
    end
  end
end