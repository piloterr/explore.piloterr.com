describe 'POST api/v1/tasks/', type: :request do
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }

  let(:api_v1_task_path) { '/api/v1/tasks' }

  describe 'POST create' do
    let(:title)              { 'MyTask' }
    let(:is_completed)       { false }
    let(:due_at)             { '2020-03-26 12:02:01.037150' }
    let(:user_id)            { user.id }

    let(:params) do
      {
        task: {
          title: title,
          is_completed: is_completed,
          due_at: due_at,
          user_id: user.id
        }
      }
    end

    it 'returns a successful response' do
      post api_v1_task_path, params: params, headers: auth_headers, as: :json

      expect(response).to have_http_status(:success)
    end

    it 'create the task' do
      expect {
        post api_v1_task_path, params: params, headers: auth_headers, as: :json
      }.to change(Task, :count).by(1)
    end

    it 'returns the task' do
      post api_v1_task_path, params: params, headers: auth_headers, as: :json

      expect(json[:data][:title]).to eq(task.title)
      expect(json[:data][:is_completed]).to eq(task.is_completed)
    end

    it 'returns error if title missing' do
      params[:task][:title] = ''

      post api_v1_task_path, params: params, headers: auth_headers, as: :json
      expect(json[:errors]).to eq ["Title can't be blank"]
    end
  end
end
