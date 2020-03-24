# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
#  title        :string
#  due_at       :date
#  is_completed :boolean
#  user_id      :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_tasks_on_user_id  (user_id)
#

FactoryBot.define do
  factory :task do
    title { 'MyTask' }
    due_at { '2020-03-21' }
    is_completed { false }
    user { nil }
  end
end
