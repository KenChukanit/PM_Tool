require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
    describe '#new' do
        context 'User Signed in' do
            before do
                session[:user_id] = FactoryBot.create(:user)
            end
            it 'renders new template' do
                get :new
                expect(response).to render_template(:new)
            end
            it 'set an instance variable with a new project instance' do
                get :new
                expect(assigns(:project)).to be_a_new(Project)
            end
        end
        context 'User Not Signed in' do
            before do
                session[:user_id] = nil
            end
            it 'redirect to new session template' do
                get :new
                expect(response).to redirect_to(new_session_path)
            end
        end
    end######    End of #new
    describe '#create' do
        context 'User Signed in' do
            before do
                session[:user_id] = FactoryBot.create(:user)
            end
            context 'Valid Parameter' do
                def valid_request
                    post(:create, params:{project: FactoryBot.attributes_for(:project)})
                end
                it 'create a new project in database' do
                    count_before = Project.count
                    valid_request
                    count_after = Project.count
                    expect(count_after).to(eq(count_before + 1))
                end
                it 'redirect us to show page of projects' do
                    valid_request
                    project = Project.last
                    expect(response).to(redirect_to(project_path(project.id)))
                end
                it 'it show flash msg project created' do
                    valid_request
                    expect(flash[:notice]).to be
                end
            end
            context 'Invalid Parameter' do
                def invalid_request
                    post(:create, params:{project: FactoryBot.attributes_for(:project, title: nil)})
                end
                it 'does not record in database' do
                    count_before = Project.count
                    invalid_request
                    count_after = Project.count
                    expect(count_after).to(eq(count_before))
                end
                it 'render new template' do
                    invalid_request
                    expect(response).to render_template(:new)
                end
            end
        end
        context 'User Not signed in' do
            def valid_request
                post(:create, params:{project: FactoryBot.attributes_for(:project)})
            end
            it 'should redirect to new session path' do
                valid_request
                expect(response).to redirect_to(new_session_path)
            end
        end
    end######    End of #create
    describe '#index' do
        it 'render index template' do
            get(:index)
            expect(response).to render_template(:index)
        end
        it 'assign instance variables to projects' do
            project1 = FactoryBot.create(:project)
            project2 = FactoryBot.create(:project)
            project3 = FactoryBot.create(:project)
            get(:index)
            expect(assigns(:projects)).to eq([project3,project2,project1])
        end
    end######    End of #index
    describe '#show' do   ####NEED TO FIX @comments
        it 'render show template' do
            project = FactoryBot.create(:project)
            get(:show, params:{id: project.id})
            expect(response).to render_template(:show)
        end
        it 'set instance variable for that @project' do
            project = FactoryBot.create(:project)
            get(:show, params:{id: project.id})
            expect(assigns(:project)).to(eq(project))
        end
        it 'set instance variables for @tasks of that project' do
            session[:user_id] = FactoryBot.create(:user)
            project = FactoryBot.create(:project)
            task = FactoryBot.create(:task, project: project)
            task2 = FactoryBot.create(:task, project: project)
            task3 = FactoryBot.create(:task, project: project)
            get(:show, params:{id: project.id})
            expect(assigns(:tasks)).to eq([task3,task2,task])
        end
        it 'set instance variables for @discussions of that project' do
            session[:user_id] = FactoryBot.create(:user)
            user1 = FactoryBot.create(:user)
            user2 = FactoryBot.create(:user)
            project = FactoryBot.create(:project)
            discussion = FactoryBot.create(:discussion, project: project, user: user2)
            discussion2 = FactoryBot.create(:discussion, project: project, user: user1)
            discussion3 = FactoryBot.create(:discussion, project: project, user: user2)
            get(:show, params:{id: project.id})
            expect(assigns(:discussions)).to eq([discussion3,discussion2,discussion])
        end
        # it 'set instance variables for @comments of that project@discussion' do
        #     session[:user_id] = FactoryBot.create(:user)
        #     user1 = FactoryBot.create(:user)
        #     user2 = FactoryBot.create(:user)
        #     project = FactoryBot.create(:project, user: user2)
        #     discussion = FactoryBot.create(:discussion, project: project, user: user2)
        #     comment= FactoryBot.create(:comment, user: user2, discussion: discussion)
        #     comment2 = FactoryBot.create(:comment, user: user1, discussion: discussion)
        #     comment3 = FactoryBot.create(:comment, user: user2, discussion: discussion)
        #     get(:show, params:{id: project.id, discussion_id: discussion.id})
        #     expect(assigns(:comments)).to eq([comment3,comment2,comment])
        # end
    end######    End of #show
    describe '#destroy' do
        context 'User signed in' do
            context 'Owner of project' do
                before do
                    current_user = FactoryBot.create(:user)
                    session[:user_id] = current_user.id
                    @project = FactoryBot.create(:project, user: current_user)
                    delete(:destroy, params:{id: @project.id})
                end
                it 'remove project from database' do
                    expect(Project.find_by(id: @project.id)).to(be(nil))
                end
                it 'redirect to index template' do
                    expect(response).to redirect_to(projects_path)
                end
            end
            context 'Not Owner of project' do
                before do
                    current_user = FactoryBot.create(:user)
                    session[:user_id] = current_user.id
                    @project = FactoryBot.create(:project)
                    delete(:destroy, params:{id: @project.id})
                end
                it 'does not remove the project' do
                    expect(Project.find(@project.id)).to eq(@project)
                end
                it 'redirect to index path' do
                    expect(response).to redirect_to(projects_path)
                end
                it 'show the alert for not authorized' do
                    expect(flash[:alert]).to be
                end
            end
        end
        context 'User not signed in' do
            before do
                session[:user_id] = nil
                @project = FactoryBot.create(:project)
                delete(:destroy, params:{id: @project.id})
            end
            it 'redirect user to new session path' do
                expect(response).to redirect_to(new_session_path)
            end
        end
    end######    End of #destroy
    describe '#edit' do
        context 'User Signed in' do
            context 'Owner of project' do
                before do
                    current_user = FactoryBot.create(:user)
                    session[:user_id] = current_user.id
                    @project = FactoryBot.create(:project, user: current_user)
                    get(:edit ,params:{id: @project.id})
                end
                it 'should bring user to edit template' do
                    expect(response).to render_template(:edit)
                end
            end
            context 'Not owner of project' do
                before do
                    current_user = FactoryBot.create(:user)
                    session[:user_id] = current_user.id
                    @project = FactoryBot.create(:project)
                    get(:edit ,params:{id: @project.id})
                end
                it 'redirect to index path' do
                    get(:edit ,params:{id: @project.id})
                    expect(response).to redirect_to(projects_path)
                end
                it 'show the alert for not authorized' do
                    get(:edit ,params:{id: @project.id})
                    expect(flash[:alert]).to be
                end
            end
        end
        context 'User Not signed in' do
            before do
                session[:user_id] = nil
                @project = FactoryBot.create(:project)
                get(:edit ,params:{id: @project.id})
            end
            it 'redirect user to new session path' do
                expect(response).to redirect_to(new_session_path)
            end
        end
    end######    End of #edit
    describe '#update' do
        context "User Signed in (don't have to do context owner since only owner can do)" do
            before do
                user1 = FactoryBot.create(:user)
                @project = FactoryBot.create(:project, user: user1)
                session[:user_id] = user1.id
            end
            context 'Valid parameter' do 
                it 'updates the project with new attributes' do
                    new_title = "new #{@project.title}"
                    patch(:update, params:{id: @project.id, project:{title: new_title}})
                    expect(@project.reload.title).to(eq(new_title))
                end
                it 'redirect to show page' do
                    new_title = "new #{@project.title}"
                    patch(:update, params:{id: @project.id, project:{title: new_title}})
                    expect(response).to redirect_to(@project)
                end
                it 'show flash message that it has been updated' do
                    new_title = "new #{@project.title}"
                    patch(:update, params:{id: @project.id, project:{title: new_title}})
                    expect(flash[:notice]).to be
                end
            end
            context 'Invalid parameter ' do
                before do
                    user1 = FactoryBot.create(:user)
                    @project = FactoryBot.create(:project, user: user1)
                    session[:user_id] = user1.id
                end
                it 'does not update the project with new attributes' do
                    new_title = nil
                    patch(:update, params:{id: @project.id, project:{title: new_title}})
                    expect(@project.reload.title).to(eq(@project.title))
                end
                it 'should render edit page' do
                    new_title = nil
                    patch(:update, params:{id: @project.id, project:{title: new_title}})
                    expect(response).to render_template(:edit)
                end
            end
        end
    end######    End of #update
end
