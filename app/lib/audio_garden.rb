module AudioGarden

  def self.run(app)
    EventMachine.run do

      @dispatch = Rack::Builder.app do
        map '/' do
          run app
        end
      end

      @sockets = []
      
      EventMachine::WebSocket.start(host: ENV['ws_host'], port: ENV['ws_port']) do |ws|

        ws.onopen do
          @sockets << ws
          ws.send(Note.current) 
        end

        ws.onmessage do |msg|
          params = JSON.parse(msg)
          Note.execute(params)
          broadcast
        end

        ws.onclose do
          @sockets.delete(ws)
        end
      end

      Rack::Server.start({
        app:    @dispatch,
        server: 'thin',
        host:   ENV['host'],
        port:   ENV['port']
      })

    end
  end

  private 

  def self.broadcast
    EventMachine.next_tick { @sockets.each{ |s| s.send(Note.current) } }
  end

end
