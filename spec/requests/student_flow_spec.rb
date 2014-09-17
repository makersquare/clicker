require 'rails_helper'


RSpec.describe "student flow" do
  
  before do
    @student = Fabricate(:user, class_groups: [
      Fabricate(:class_group, question_sets: [
        Fabricate(:question_set)
      ]), 
      Fabricate(:class_group)
    ])
  end

  let(:session) do
    { user_id: @student.id }
  end  

  it 'directs them to the sign in page' do
    get '/'
    expect(response).to render_template(:index)
  end

  describe 'github' do
    it "should login with github", :js => true do
      get "/test_sign_in/#{@student.id}"
      get '/'
      expect(response).to redirect_to('/class_groups')
    end
  end

  context 'when student accesses site' do
    it 'allows a student to sign in with github and redirects to their list of classes then individual class' do
      #accesses site
      get "/"
      expect(response).to render_template("welcome/index")
      
      #logs in & redirects to class_groups_index
      get "/test_sign_in/#{@student.id}"
      get '/'
      expect(response).to redirect_to('/class_groups')
      follow_redirect!
      expect(response.body).to include(@student.class_groups.first.name)
      expect(response.body).to include(@student.class_groups[1].name)

      #student views 1 class group on show page
      get "/class_groups/#{@student.class_groups.first.id}"
      expect(response).to render_template('class_groups/show')
      expect(response.body).to include(@student.class_groups.first.name)
      expect(response.body).to_not include(@student.class_groups[1].name)
    end
  end

end