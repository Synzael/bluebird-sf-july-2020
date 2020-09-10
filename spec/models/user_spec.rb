require 'rails_helper'
# RSPEC LAND

RSpec.describe User, type: :model do
  # test for: 
  # validations
  # associations
  # public methods 

  let(:incomplete_user) { User.new(username: '', email: "email@aa.io", age: 72,
    password: "password", political_affiliation: "cappy")}

  # will want a subject when testing uniqueness so shoulda matcher can test it
  subject(:porkchop) { User.create(username: "porkchop", email: "bacon@aa.io", age: 4,
    political_affiliation: "cappy", password: "password") }

  # it "validates presence of a username" do
  #   expect(incomplete_user).to_not be_valid
  # end

  # better error messages! 
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:age) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:political_affiliation) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_uniqueness_of(:username) }
  # uniqueness will automatically test using the subject

  describe "session_token" do
    it "assigns a session_token if none given" do
      # using FB to build demo user to test session token
      expect(FactoryBot.build(:user).session_token).not_to be_nil
      # session token is created by custom method :ensure_session_token
      # often need to write our own expect instead of shoulda for customer methods
    end
  end

  describe "password encryption"  do
    it "does not save passwords to the database" do
      FactoryBot.create(:user, username: "Harry Potter")
      # overwrote FB's username to be what we wanted
      user = User.find_by(username: "Harry Potter")
      expect(user.password).not_to eq("password")
    end
    # testing database will roll back between it blocks i.e. stuff added to test
    # db in an it block will not persist to the next it block

    it "encrypts password using BCrypt" do
      expect(BCrypt::Password).to receive(:create).with("abcdef")
      FactoryBot.build(:user, password: "abcdef")
      # FB build will only create the object but NOT save it
      # create will save it to the test db
    end
  end

  it { should have_many(:chirps) }
  # tests there is association called chirps and also that it is set up correctly
end