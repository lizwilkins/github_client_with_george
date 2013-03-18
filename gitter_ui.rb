require './ui_helper'

def welcome
  puts "Welcome to the Github command-line client."
  login_info = login
  menu(login_info)
end

def menu(login_info)
  choice = nil
  until choice == 'e'
    puts "\nWhat would you like to do:"
    puts "Press 'l' to list your Gists."
    puts "Press 'c' to create a new Gist."
    # puts "Press 'v' to view a Gist."
    # puts "Press 'u' to update a Gist."
    puts "Press 'd' to delete a Gist."
    puts "Press 'e' to exit."

    case choice = gets.chomp
    when 'l'
      list(login_info)
    when 'c'
      create(login_info)
    when 'v'
      view
    when 'u'
      update
    when 'd'
      delete(login_info)
    when 'e'
      exit
    else
      invalid
    end
  end
end

def login    # need to validate login info
  print "\nUsername:  "
  username = gets.chomp
  print "Password:  "
  password =  STDIN.noecho(&:gets).chomp
  puts ''
  {:username => 'epicodusstudent', :password => 'Poiu0987'}
end

def list(login_info)
  puts "\nHere is your gist list:"
  gists = Gist.list(login_info)
  gists.each {|gist| puts "ID #{gist.id}  Filename: #{gist.filename}   Url: #{gist.url} " }
end

def create(login_info)   # need to show error msgs
  public_attribute = nil
  while public_attribute.nil?
    print "\nWould you like this Gist to be public (y/n): "
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
  # if Gist.create({:public => public_attribute, :description => description, :files => files}, login_info).nil?
  #   puts "Gist failed..."
  #   delete(login_info)
  # else
  #   puts "Create Successful!"
  # end
end

def delete(login_info)    # need to show error msgs
  list(login_info)
  print "\nWhich Gist would you like to delete (specify by ID):  "
  gist_id = gets.chomp
  Gist.delete(gist_id, login_info)
  # if Gist.delete(gist_id, login_info).nil?
  #   puts "Delete failed...did you use a valid ID?"
  #   delete(login_info)
  # else
  #   puts "Delete Successful!"
  # end
end

welcome