require File.expand_path '../../spec_helper.rb', __FILE__

describe Note do

  before :each do 
    Note.truncate
    @note_1 = Note.create(name: 'ukulele_c1', color: '255, 0, 50')
    @note_2 = Note.create(name: 'ukulele_e1', color: '0, 238, 255')
    @note_3 = Note.create(name: 'ukulele_d1', color: '96, 13, 122')
  end

  it "should return all notes in json format" do
    expect(JSON.parse(Note.current).length).to eq(3)
  end

  it "should return all notes with correct values" do
    expect(JSON.parse(Note.current)[0]["name"]).to eq(@note_1.name)
    expect(JSON.parse(Note.current)[1]["name"]).to eq(@note_2.name)
    expect(JSON.parse(Note.current)[2]["name"]).to eq(@note_3.name)
  end

  it "should destroy notes " do
    Note.execute({"command" =>  'destroy_all'})
    expect(Note.count).to be_zero
  end

  it "should add new note" do
    expect {
      Note.execute({"command"=>"add_note", "note"=>{"x"=>281, "y"=>208, "name"=>"ukulele_asharp2", "color"=>"2178, 255, 0"}})
    }.to change(Note, :count).by(1)
  end

  it "should remove note by id" do
    expect {
      Note.execute({"command"=>"clear_notes", "note_ids" => [@note_1.id]})
    }.to change(Note, :count).by(-1)
  end

  it "should update note coordinates" do
    Note.execute({"command"=>"drag_note", "note"=>{ "x"=>281, "y"=>208, "id" => @note_1.id}})
    expect(Note.find(id: @note_1.id).coordinates).to eq({x: 281, y:208})
  end

end