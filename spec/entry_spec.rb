require_relative '../models/entry'

  RSpec.describe Entry do

    describe "attributes" do
      # let allows for defining an entry method once in a spec file
      let(:entry) { Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com') }

      # communicates that the specs test the Entry attributes
      it "responds to name" do
        # checks whether entry.name is valid code
        expect(entry).to respond_to(:name)
      end

      it "reports its name" do
        expect(entry.name).to eq('Ada Lovelace')
      end

      it "responds to phone number" do
        expect(entry).to respond_to(:phone_number)
      end

      it "reports its phone_number" do
       expect(entry.phone_number).to eq('010.012.1815')
      end


      it "responds to email" do
        expect(entry).to respond_to(:email)
      end

      it "reports its email" do
       expect(entry.email).to eq('augusta.king@lovelace.com')
     end
    end

    # test of to_s instance method, which converts the Entry attributes to a string - kept separate from describe 'attributes'
    describe "#to_s" do
      it "prints an entry as a string" do
        entry = Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
        expected_string = "Name: Ada Lovelace\nPhone Number: 010.012.1815\nEmail: augusta.king@lovelace.com"
        expect(entry.to_s).to eq(expected_string)
      end
    end
  end
