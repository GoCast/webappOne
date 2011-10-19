require 'spec_helper'

describe ApiController do

  describe "GET 'call'" do
    it "should be successful" do
      get 'call'
      response.should be_success
    end
  end

end
