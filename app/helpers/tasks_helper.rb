module TasksHelper
  def url_for_step_one
    @task.new_record? ? create_step_one_tasks_path : update_step_one_task_path(@task)
  end

  def url_for_back_button
    @task.new_record? ? new_step_one_tasks_path : edit_step_one_task_path
  end

  def submit_text
    @task.new_record? ? 'Create Task' : 'Update Task'
  end
end
