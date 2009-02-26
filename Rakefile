require 'rake'

desc "add DOTFILE from system to the working directory"
task :add do
  file = File.basename(ENV['DOTFILE']).sub(/^\./, '') # normalize the input
  file_from_system = File.join(ENV['HOME'], ".#{file}")

  if !File.exist?(file_from_system)
    puts "no file exists at ~/.#{file}"
    exit
  elsif File.symlink?(file_from_system)
    puts "the file is already a symlink at ~/.#{file}"
    exit
  elsif File.exist?(file)
    print "overwrite #{file} in current directory? [yn] "
    exit if $stdin.gets.chomp != 'y'
  end

  puts "moving #{File.directory?(file_from_system) ? 'directory' : 'file'} ~/.#{file} into current directory"
  system %Q{mv "#{file_from_system}" "#{file}"}
  link_file(file)
end

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README LICENSE].include? file
    
    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if is_linked?(file)
        puts "~/.#{file} is already linked"
      elsif replace_all
        replace_file(file)
      else
        loop do
          print "overwrite ~/.#{file}? [yndaq] "
          case $stdin.gets.chomp
          when 'a'
            replace_all = true
            replace_file(file)
            break
          when 'y'
            replace_file(file)
            break
          when 'd'
            system %Q{diff -ur "$HOME/.#{file}" "$PWD/#{file}"}
          when 'q'
            exit
          else
            puts "skipping ~/.#{file}"
            break
          end
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
  
  dotfiles.sort.each do |fn|
    if File.exist?(fn.sub(/^\./, ''))
      if is_linked?(fn.sub(/^\./, ''))
        puts "I #{fn}"
      else
        puts "! #{fn}"
      end
    else
      puts "  #{fn}"
    end
  end
end

def is_linked?(file)
  File.symlink?(File.join(ENV['HOME'], ".#{file}")) &&
    File.readlink(File.join(ENV['HOME'], ".#{file}")) == File.expand_path(file)
end

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end
