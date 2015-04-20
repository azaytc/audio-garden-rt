class Note < Sequel::Model

  class << self 

    def current
      self.all.map(&:values).to_json
    end

    def execute(params)
      @params = params
      self.send(params['command'])
    end

    def destroy_all
      all.map(&:destroy)  
    end

    def add_note
      create(@params["note"])
    end

    def clear_notes
      notes = where(id: @params['note_ids'])
      notes.map(&:destroy) if notes
    end

    def drag_note
      note = find(id: @params['note']['id'])
      note.update(x: @params['note']['x'], y: @params['note']['y']) if note
    end
    
  end

  def coordinates
    {x: x, y: y}
  end
end