require 'rails_helper'

RSpec.describe Project, type: :model do
  def project 
      FactoryBot.create(:project)
  end

  # Write the following tests for the PM Tool Project Model:

  # Validation of the presence of the project title
  # Validation of the uniqueness of the project title
  # Validation that the due_date must be greater than today's date
describe 'validations' do
  it 'title must be presence' do
    p = project
    p.title = nil
    p.valid?
    expect(p.errors).to have_key(:title)
  end

  it 'title must be uniqueness' do
    p = project
    p2 = FactoryBot.build(:project, title: p.title)
    p2.valid?
    expect(p2.errors).to have_key(:title)
  end

  it 'due date must be greater than today date' do
    p = project
    p.due_date = p.created_at
    p.valid?
    expect(p.errors).to have_key(:due_date)
  end
end







end
