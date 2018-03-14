require_relative 'verifier_class'


#raise "Enter a file to be verified" unless ARGV.count == 1 #verifies that an argument has been passed in
raise "Please enter a file" unless ARGV.count == 1
input_file = ARGV[0]
raise "Please enter a valid file" unless File.file?(input_file) #verifies that input file is a file
verifier = Verifier::new 
verifier.run input_file

