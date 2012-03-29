#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history'
require 'tempfile'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

IRB.conf[:AUTO_INDENT] = true

# adapted from http://github.com/gilesbowkett/utility-belt/blob/0a542e50a3c27f883688358f70c89719be651e4b/lib/utility_belt/interactive_editor.rb
def vim
  unless @vim_tempfile
    @vim_tempfile = Tempfile.new("irb_tempfile")
  end
  system(%[vim -c ":set syntax=ruby" #{@vim_tempfile.path}])
  Object.class_eval(`cat #{@vim_tempfile.path}`)
rescue Exception => error
  puts error
end
alias :vi :vim