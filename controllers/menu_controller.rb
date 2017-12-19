require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    # displays the main menu options to the command line
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - Exit"
    print "Enter your selection: "

    # retrieves user input from the command line using gets
    selection = gets.to_i

    # uses a case statement operator to determine the proper response to the user's input
    case selection
      when 1
        system "clear"
        view_all_entries
        main_menu
      when 2
        system "clear"
        create_entry
        main_menu
      when 3
        system "clear"
        search_entries
        main_menu
      when 4
        system "clear"
        read_csv
        main_menu
      when 5
        puts "Good-bye!"
        # terminates the program using exit(0). 0 signals the program is exiting without an error
        exit(0)
      # uses an else to catch invalid user input and prompt the user to retry
      else
        system "clear"
        puts "Sorry, that is not a valid input"
        main_menu
    end
  end

  def view_all_entries
    # iterates through all entries in AddressBook using each
    address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s
      # calls entry_submenu to display a submenu for each entry
    entry_submenu(entry)
    end
    system "clear"
    puts "End of entries"
  end

  def create_entry
    system "clear"
     puts "New AddressBloc Entry"
     # uses print to prompt the user for each Entry attribute (print works just like puts, except that it doesn't add a newline)
     print "Name: "
     name = gets.chomp
     print "Phone number: "
     phone = gets.chomp
     print "Email: "
     email = gets.chomp

     # adds a new entry to address_book using add_entry to ensure that the new entry is added in the proper order.
     address_book.add_entry(name, phone, email)

     system "clear"
     puts "New entry created"
  end

  def search_entries
    print "Search by name: "
      # gets the name that the user wants to search for and store it in name
      name = gets.chomp
      # calls search on address_book which will either return a match or nil
      match = address_book.binary_search(name)
    system "clear"
    # checks if search returned a match
    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end
  end

  def search_submenu(entry)
  # prints out the submenu for an entry
  puts "\nd - delete entry"
  puts "e - edit this entry"
  puts "m - return to main menu"
  # saves the user input to selection
    selection = gets.chomp

    # uses a case statement and take a specific action based on user input
    case selection
      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        search_submenu(entry)
    end
  end

  def read_csv
    print "Enter CSV file to import: "
     file_name = gets.chomp

    # checks to see if the file name is empty. If it is then we return the user back to the main menu by calling main_menu
    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

    # import the specified file with import_from_csv on address_book. We then clear the screen and print the number of entries that were read from the file. All of these commands are wrapped in a begin/rescue block. begin will protect the program from crashing if an exception is thrown
    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end
  end

  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end

  def edit_entry(entry)
    # Each gets.chomp statement gathers user input and assigns it to an appropriately named variable
    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp

    # sets attributes on entry only if a valid attribute was read from user input.
    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"

    # prints out entry with the updated attributes
    puts "Updated entry:"
    puts entry
  end


  def entry_submenu(entry)
    # displays the submenu options
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    # chomp removes any trailing whitespace from the string gets returns. This is necessary because "m " or "m\n" won't match  "m"
    selection = gets.chomp

    case selection
      # when the user asks to see the next entry, we can do nothing and control will be returned to view_all_entries
      when "n"

      when "d"
        delete_entry(entry)

      when "e"
        edit_entry(entry)
        entry_submenu(entry)
      # returns the user to the main menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        entry_submenu(entry)
    end
  end
end
