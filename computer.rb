class Computer
    
    @@users = {}
    
    def initialize(username, password)
        @username = username
        @password = password
        @files = {}
        @@users[username.to_sym] = password
    end
    
    def create(filename)
        time = Time.now
        @files[filename.to_sym] = time
        puts "File #{filename} created by #{@username} at #{time}."
    end
    
    def get_files
        return @files
    end
    
    
    def Computer.get_users
        return @@users
    end
    
end

my_computer = Computer.new("filmmaker", "123456")
my_computer.create("ruby.rb")

puts my_computer.get_files
puts Computer.get_users