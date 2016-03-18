#!/usr/bin/env ruby

trap('SIGINT') { exit }

if ARGV.length < 2
  puts "Usage: #{$0} directory keyword_from_url"
  puts "Example: #{$0} ~/Projects/whatever localhost"
  exit
end

filetypes = %w(js css html scss)
directory = ARGV[0]
keyword = ARGV[1]
puts "Watching #{directory} and subfolders for changes in project files..."

while true do
  files = []
  filetypes.each do |type|
    files += Dir.glob(File.join( directory, '**', "*.#{type}"))
  end
  new_hash = files.collect { |f| [ f, File.stat(f).mtime.to_i ] }
  hash ||= new_hash
  diff_hash = new_hash - hash

  unless diff_hash.empty?
    hash = new_hash

    diff_hash.each do |df|
      puts "Detected change in #{df[0]}, refreshing"
      %x{osascript<<ENDGAME
        tell application "Google Chrome"
          set windowList to every window
          repeat with aWindow in windowList
            set tabList to every tab of aWindow
            repeat with atab in tabList
              if (URL of atab contains "#{keyword}") then
                tell atab to reload
              end if
            end repeat
          end repeat
        end tell
ENDGAME
}
    end
  end

  sleep 1
end
