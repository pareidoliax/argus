require 'spec_helper'

module Argus
  describe VideoStreamer do
    Given(:tcp_socket) { flexmock("TCPSocket", send: nil).should_ignore_missing }
    Given(:streamer) { VideoStreamer.new(socket: tcp_socket) }
    Given(:udp_socket) { flexmock("UDPSocket", send: nil).should_ignore_missing }

    describe "starting the stream" do
      When { streamer.start(udp_socket) }
      Then { udp_socket.should have_received(:send) }
      Then { udp_socket.should have_received(:close) }
    end

    describe "receiving data" do
      Given { streamer.start(udp_socket) }
      When(:result) { streamer.receive_data }
      Then { result.is_a?(VideoData) }
    end
  end
end
