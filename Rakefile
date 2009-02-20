require 'rake'

desc "add a system's dot file (or directory) to the working directory"
task :add do
  dotfile = ENV['DOTFILE']
  system_dotfile = File.join(ENV['HOME'], ".#{dotfile}")

  if !File.exist?(system_dotfile)
    print "no file exists at #{system_dotfile}"
    exit
  elsif File.symlink?(system_dotfile)
    print "the is already a symlink at #{system_dotfile}"
    exit
  elsif File.exist?(dotfile)
    print "overwrite #{dotfile}? [yn] "
    exit if $stdin.gets.chomp != 'y'
  end

  puts "moving #{File.directory?(system_dotfile) ? 'directory' : 'file'} #{system_dotfile.gsub(ENV['HOME'], '~')} into current directory"
  system %Q{mv "#{system_dotfile}" "#{dotfile}"}
  link_file(dotfile)
end

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README LICENSE].include? file
    
    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file}"
        end
      end
    else
      link_file(file)
    end
  end
end

desc "list the status of the system's dot files and directories in user's home directory"
task :status do
  dotfiles = Dir[File.join(ENV['HOME'], ".*")].collect {|fn| File.basename(fn) }
  dotfiles -= %w(. .. .dotfiles .DS_Store .Trash)
  dotfiles.reject! {|fn| fn =~ /(_history|\.tmp|~)$/ }
  
  dotfiles.each do |fn|
    if File.exist?(fn.sub(/^\./, ''))
      if File.symlink?(File.join(ENV['HOME'], fn))
        puts "I #{fn}"
      else
        puts "! #{fn}"
      end
    else
      puts "  #{fn}"
    end
  end
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end
