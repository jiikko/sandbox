# https://www.rubyguides.com/2019/05/ruby-ffi/
# Crashed
# -- Control frame information -----------------------------------------------
# c:0006 p:---- s:0037 e:000036 CFUNC  :libvlc_media_new_path
# c:0005 p:0032 s:0031 e:000030 METHOD /Users/koji/src/sandbox/ruby/ffi/vlc.rb:21
# c:0004 p:0044 s:0023 e:000022 TOP    /Users/koji/src/sandbox/ruby/ffi/vlc.rb:26 [FINISH]
# c:0003 p:---- s:0020 e:000019 CFUNC  :require
# c:0002 p:0110 s:0015 e:000014 METHOD /Users/koji/.rbenv/versions/2.5.1/lib/ruby/2.5.0/rubygems/core_ext/kernel_require.rb:59 [FINISH]
# c:0001 p:0000 s:0003 E:000ee0 (none) [FINISH]

require 'ffi'

module VLC
  extend FFI::Library
  ffi_lib 'vlc'
  # ffi_lib '/usr/local/Caskroom/vlc/3.0.11.1/VLC.app/Contents/MacOS/lib/libvlc.dylib'
  # ffi_lib '/usr/local/Caskroom/vlc/3.0.11.1/VLC.app/Contents/MacOS/lib/libvlc.ylib'
  attach_function :get_version, :libvlc_get_version, [], :string
  attach_function :new, :libvlc_new, [:int, :int], :pointer
  attach_function :libvlc_media_new_path, [:pointer, :string], :pointer
  attach_function :libvlc_media_player_new_from_media, [:pointer], :pointer

  attach_function :play, :libvlc_media_player_play, [:pointer], :int
  attach_function :stop, :libvlc_media_player_stop, [:pointer], :int
  attach_function :pause, :libvlc_media_player_pause, [:pointer], :int
end

puts VLC.get_version

def run
  vlc    = VLC.new(0, 0)
  path = '/Users/koji/src/sandbox/ruby/ffi/that.mp3'
  media  = VLC.libvlc_media_new_path(vlc, path)
  player = VLC.libvlc_media_player_new_from_media(media)
  VLC.play(player)
end

run
