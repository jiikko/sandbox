code = <<-CODE
str = "hi"
proc {
  str = "2"
  puts str
}
proc {
  str = "3"
  puts str

  proc {
    str = "3"
    puts str

  proc {
    str = "4"
    puts str
  }
  }
}
CODE
puts RubyVM::InstructionSequence.compile(code).disasm
