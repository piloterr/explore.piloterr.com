module Api
  module V1
    class TasksController < Api::V1::ApiController
      def index
        @tasks = Task.all
        render :index
      end

      def create
        @task = Task.new(task_params)

        if @task.save
          @task.user_id = current_user.id
          render :create, status: :created
        else
          render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        @task = Task.find(params[:id])
        if @task.save
          Task.update(task_params)
          render :update, status: :created
        else
          render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
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
