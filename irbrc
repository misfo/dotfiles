#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history'
require 'tempfile'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

IRB.conf[:AUTO_INDENT] = true

def edit_file(file)
  full_filename = if file
                    File.expand_path file
                  else
                    @vim_tempfile ||= File.join("", "tmp", "irb_#{Time.now.strftime '%Y-%m-%d_%H-%M'}.rb")
                  end
  yield full_filename
  eval File.read(full_filename)
end

def subl(file=nil)
  edit_file file do |filename|
    system "subl", "-w", filename
  end
end

def vim(file=nil)
  edit_file file do |filename|
    system "vim", filename
  end
end
alias :vi :vim
