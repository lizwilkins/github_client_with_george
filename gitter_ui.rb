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
    puts "Press 'v' to view detailed info for a Gist."
    puts "Press 'u' to update a Gist."
    puts "Press 'd' to delete a Gist."
    puts "Press 'e' to exit."

    case choice = gets.chomp
    when 'l'
      list(login_info)
    when 'c'
      create(login_info)
    when 'v'
      view(login_info)
    when 'u'
      update(login_info)
    when 'd'
      delete(login_info)
    when 'e'
      exit
    else
      invalid
    end
  end
end

def view(login_info)
  gists = list(login_info)
  puts "Which Gist would you like? (select by number):"
  gist = gists[gets.chomp.to_i-1]
  puts "URL: " + gist.url
  puts "ID: " + gist.id
  puts "Filename: " + gist.filename
  puts "Description: " + gist.description
  gist
end

def update(login_info)
  gist = view(login_info)
  filename = gist.filename
  description = gist.description
  content = gist.content
  # loop through files for gist
  #   puts "File #{file.filename} info:"
  #   file.view
  #   print "Do you want to modify this file (y/n):  "
  #   choice = gets.chomp
  #   if choice == 'y'
      choice = nil
      until choice == 'e'
        puts "What element do you want to modify?"
        puts "Press 'f' to change the filename."
        puts "Press 'd' to change the description."
        puts "Press 'c' to change the content."
        puts "Press 'u' to update the gist."
        puts "Press 'e' to exit."
        case choice = gets.chomp
        when 'f'
          print "Enter the filename:  "
          filename = gets.chomp   # syntax check
          # change_filename
        when 'd'
          print "Enter the description:  "
          description = gets.chomp
          # change_description
        when 'c'
          print "Enter the content:  "
          content = gets.chomp
          # change_content
        when 'u'
          # update_file 
          gist.view
          print "Do you accept these changes (y/n):  "
          if gets.chomp == 'y'
            gist.update('filename' => filename, 'description' => description, 'content' => content)
          end
        when 'e'
        else
          puts "Invalid input."
        end
      end
  #   end
  # end
  # puts "What else do you want to modify?"
  # view and accept then update
  # gist.update('filename' => filename)
end

def login    # need to validate login info
  print "\nUsername:  "
  # username = gets.chomp
  # print "Password:  "
  # password =  STDIN.noecho(&:gets).chomp
  # puts ''
  {:username => 'epicodusstudent', :password => 'Poiu0987'}
end

def list(login_info)
  puts "\nHere is your gist list:"
  gists = Gist.list(login_info)
  gists.each_with_index {|gist,i| puts "#{i+1}. ID #{gist.id}  Filename: #{gist.filename}   Url: #{gist.url} " }
  gists
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
  gists = list(login_info)
  print "\nWhich Gist would you like to delete (specify by number):  "
  gist = gists[gets.chomp.to_i-1]
  gist.delete(login_info)
  # if Gist.delete(gist_id, login_info).nil?
  #   puts "Delete failed...did you use a valid ID?"
  #   delete(login_info)
  # else
  #   puts "Delete Successful!"
  # end
end

welcome