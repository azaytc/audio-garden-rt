class Note < Sequel::Model

  def self.current
    self.all.map(&:values).to_json
  end

  def self.execute(params)
    @params = params
    self.send(params['command'])
  end

  def self.destroy_all
    all.map(&:destroy)  
  end

  def self.add_note
    create(@params["note"])
  end

  def self.clear_notes
    notes = where(id: @params['note_ids'])
    notes.map(&:destroy) if notes
  end

  def self.drag_note
    note = find(id: @params['note']['id'])
    note.update(x: @params['note']['x'], y: @params['note']['y']) if note
  end
end