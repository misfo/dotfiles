#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history'
require 'pp'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

IRB.conf[:AUTO_INDENT] = true

EDITORS = {
  :subl => lambda do |filename, line_number, wait|
    system "subl", *((wait ? ["-w"] : []) + ["#{filename}:#{line_number}"])
  end,
  :vim => lambda do |filename, line_number, wait|
    system "vim", "+#{line_number}", filename
  end
}
TEMPFILE = File.join "", "tmp", "irb_#{Time.now.strftime '%Y-%m-%d_%H-%M'}.rb"

def edit_file(editor, file=nil, line=1)
  file, line = nil, file if file.is_a? Numeric
  edit = EDITORS.fetch editor
  if file
    edit[File.expand_path(file), line, false]
  else
    edit[TEMPFILE, line, true]
    eval File.read(TEMPFILE)
  end
end

def subl(*args) edit_file :subl, *args end
def vim(*args)  edit_file :vim,  *args end
alias :vi :vim
