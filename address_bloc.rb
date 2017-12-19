require_relative 'controllers/menu_controller'

# creates a new MenuController when AddressBloc starts
menu = MenuController.new

# uses system "clear" to clear the command line
system "clear"
puts "Welcome to AddressBloc!"

# calls main_menu to display the menu
menu.main_menu
