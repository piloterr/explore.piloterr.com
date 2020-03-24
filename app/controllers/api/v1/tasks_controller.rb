module Api
  module V1
    class TasksController < Api::V1::ApiController
      def index
        @tasks = Task.all
        render :index
      end

      def create
        @task = Task.new(task_params)
        return unless @task.save

        render :create, status: :created
      end

      def show
        render :show
      end

      def update
        @task = Task.find(params[:id])
        return unless @task.save

        Task.update!(task_params)
        render :update, status: :created
      end

      def destroy
        Task.find(params[:id]).destroy
      end

      private

      def task_params
        params.require(:task).permit(:title, :due_at, :is_completed, :user_id)
      end
    end
  end
end
