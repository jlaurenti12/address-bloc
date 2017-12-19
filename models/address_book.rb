require_relative 'entry'
require "csv"

  class AddressBook
    attr_reader :entries

    def initialize
      @entries = []
    end

    def add_entry(name, phone_number, email)
      # creates a variable to store the insertion index
      index = 0
      entries.each do |entry|
      # compares name with the name of the current  entry. If name lexicographically proceeds entry.name, we've found the index to insert at. Otherwise we increment index and continue comparing with the other entries
        if name < entry.name
          break
        end
        index+= 1
      end
      # inserts a new entry into entries using the calculated `index
      entries.insert(index, Entry.new(name, phone_number, email))
    end

    def import_from_csv(file_name)
       # Uses File.read to read the csv file that used as an argument
       csv_text = File.read(file_name)
       # The result of CSV.parse is an object of type CSV::Table
       csv = CSV.parse(csv_text, headers: true, skip_blanks: true)

       # iterates over the CSV::Table object's rows
       csv.each do |row|
         # creates a hash for each row
         row_hash = row.to_hash
         # converts each row_hash to an Entry by using the add_entry method which will also add the Entry to the AddressBook's entries
         add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
       end
    end

    def binary_search(name)
      # saves the index of the leftmost item in the array in a variable named lower
      lower = 0
      upper = entries.length - 1

      # loops while our lower index is less than or equal to our upper index
      while lower <= upper

        # finds the middle index by taking the sum of lower and upper and dividing it by two
        mid = (lower + upper) / 2
        mid_name = entries[mid].name

        # compares the name that we are searching for, name, to the name of the middle index, mid_name
        if name == mid_name
          return entries[mid]
        elsif name < mid_name
          upper = mid - 1
        elsif name > mid_name
          lower = mid + 1
        end
      end

    # if no match is found, returns nil
    return nil
  end

end
