class Note < Sequel::Model

  def self.process_data(params)
    if params['command'] == "destroy_all"
      all.map(&:destroy)
    elsif params['command'] == 'add_note'
      note = create(params["note"])
    elsif params['command'] == 'clear_notes'
      notes = where(id: params['note_ids'])
      notes.map(&:destroy) if notes
    elsif params['command'] == 'drag_note'
      note = find(id: params['note']['id'])
      note.update(x: params['note']['x'], y: params['note']['y']) if note
    end

    self.all
  end

end