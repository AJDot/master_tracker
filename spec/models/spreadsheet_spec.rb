describe Spreadsheet do
  it "belongs to user" do
    new_user = Fabricate(:user)
    new_sheet = Fabricate(:spreadsheet, user: new_user)
    expect(new_sheet.user).to eq(new_user)
  end

  it "has many rows" do
    new_sheet = Fabricate(:spreadsheet)
    row1 = Fabricate(:row, spreadsheet: new_sheet)
    row2 = Fabricate(:row, spreadsheet: new_sheet)
    expect(new_sheet.rows.count).to eq(2)
  end

  it "does not save a without a user" do
    ruby = Fabricate.build(:spreadsheet, user: nil)
    ruby.save
    expect(Spreadsheet.count).to eq(0)
  end

  it "won't save without a name" do
    new_sheet = Fabricate.build(:spreadsheet, name: nil)
    new_sheet.save
    expect(Spreadsheet.count).to eq(0)
  end

  it "must have a unique name for a user" do
    new_user = Fabricate(:user)
    sheet1 = Fabricate.build(:spreadsheet, name: 'dup', user: new_user)
    sheet2 = Fabricate.build(:spreadsheet, name: 'dup', user: new_user)
    sheet1.save
    sheet2.save
    expect(new_user.spreadsheets.count).to eq(1)
  end

  it "can have a duplicate name if they are for different users" do
    new_user = Fabricate(:user)
    new_user2 = Fabricate(:user)
    sheet1 = Fabricate.build(:spreadsheet, name: 'dup', user: new_user)
    sheet2 = Fabricate.build(:spreadsheet, name: 'dup', user: new_user2)
    sheet1.save
    sheet2.save
    expect(new_user.spreadsheets.count).to eq(1)
    expect(new_user2.spreadsheets.count).to eq(1)
  end

  describe '#create_date' do
    it "returns a string" do
      sheet = Fabricate(:spreadsheet)
      expect(sheet.create_date).to be_instance_of(String)
    end
  end

  describe '#create_time' do
    it "returns a string" do
      sheet = Fabricate(:spreadsheet)
      expect(sheet.create_time).to be_instance_of(String)
    end
  end

  describe '#update_date' do
    it "returns a string" do
      sheet = Fabricate(:spreadsheet)
      expect(sheet.update_date).to be_instance_of(String)
    end
  end

  describe '#update_time' do
    it "returns a string" do
      sheet = Fabricate(:spreadsheet)
      expect(sheet.update_time).to be_instance_of(String)
    end
  end
end
