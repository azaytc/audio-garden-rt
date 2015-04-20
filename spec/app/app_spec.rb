require File.expand_path '../../spec_helper.rb', __FILE__

describe "Sinatra Application" do

  it "should allow accessing index page" do
    get '/'
    expect(last_response).to be_ok
  end

end