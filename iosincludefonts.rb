require 'plist'
require 'daemons'

files = []
ARGV.each do |arg|
  files << File.expand_path(arg)
end

if files.count == 0
	puts "Please pass path to folder with fonts and .plist file"
	exit
end

puts files


fonts = []
Dir.foreach(files[0]) do |item|
  if item.include? ".ttf"
  	fonts << item
  end
end





if fonts.count
	application_plist = Plist::parse_xml(files[1])

	application_plist['UIAppFonts'] = fonts

	puts "Found following fonts:"
	puts fonts
	puts "Continue? (y/n)"
	return if 'n' == STDIN.gets.chomp

	File.open(files[1], 'w') { |file| file.write(application_plist.to_plist) }
	puts "File updated"
else
	puts "No fonts found"
end
