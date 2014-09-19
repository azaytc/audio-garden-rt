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
          notes = Note.all
          ws.send(notes.map(&:values).to_json) 
        end

        ws.onmessage do |msg|
          params = JSON.parse(msg)
          Note.execute(params)
          notes = Note.all
          push(notes)
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

  def self.push(notes)
    EventMachine.next_tick { @sockets.each{ |s| s.send(notes.map(&:values).to_json) } }
  end

end
