require './ui_helper'

def welcome
  puts "Welcome to the Github command-line client."
  login_info = login
  menu(login_info)
end

def menu(login_info)
  choice = nil
  until choice == 'e'
    puts "What would you like to do:"
    puts "Press 'l' to list your Gists."
    puts "Press 'c' to create a new Gist."
    puts "Press 'v' to view a Gist."
    puts "Press 'u' to update a Gist."
    puts "Press 'd' to delete a Gist."
    puts "Press 'e' to exit."

    case choice = gets.chomp
    when 'l'
      list
    when 'c'
      create(login_info)
    when 'v'
      view
    when 'u'
      update
    when 'd'
      delete
    when 'e'
      exit
    else
      invalid
    end
  end
end

def login
  print "Username:  "
  username = gets.chomp
  print "Password:  "
  password =  STDIN.noecho(&:gets).chomp
  puts ''
  {:username => username, :password => password}
end

def create(login_info)
  public_attribute = nil
  while public_attribute.nil?
    print "Would you like this Gist to be public (y/n): "
    public_attribute = gets.chomp
    case public_attribute
    when 'y'
      public_attribute = true
    when 'n'
      public_attribute = false
    else
      puts "That wasn't a valid choice."
      public_attribute = nil
    end
  end
  puts "Type a description for the Gist, or hit Enter for no description."
  description = gets.chomp
  puts "What would you like the name of the file in the Gist to be?"
  filename = gets.chomp
  puts "Now, type the content of the Gist:"
  content = gets.chomp
  files = {filename => {:content => content}}

  Gist.create({:public => public_attribute, :description => description, :files => files}, login_info)
end

welcome