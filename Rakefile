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
