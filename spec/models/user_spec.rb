require 'spec_helper'

def user_factory(number = nil)
 User.new email: "hello#{number || Time.now.to_f}@world.com", password: "password", password_confirmation: "password"
end

describe User do

  context "validations" do

    %w[email password].each do |field|
      it { should validate_presence_of field }
    end

  end

  context "Online Status" do

    let(:user) { User.new }
    
    it "can change status to online" do
      user.online!
      user.should be_online
    end

    it "can change status to offline" do
      user.offline!
      user.should_not be_online
    end
    
  end

  context "Scopes" do
    
    it "orders by online" do
      User.should_receive(:order).with("online DESC")
      User.ordered
    end
    
  end

  context "Image url" do  

    it "returns an md5 url from the email" do
      email = "hello@world.com"
      digested_email = Digest::MD5.hexdigest email
      
      user = User.new email: email
      user.image_url.should include digested_email
    end
    
  end

  context "Digest" do  

    it "changes when a user is created or status is change" do
      user_factory(1).save
      user_digest = User.digest

      User.first.online!
      user_digest.should_not == User.digest

      user_factory(2).save
      user_digest.should_not == User.digest
    end
    
  end



  
end
