module TasksHelper
  def url_for_step_one
    @task.new_record? ? create_step_one_tasks_path : update_step_one_task_path(@task)
  end

  def url_for_step_two
    @task.new_record? ? create_step_two_tasks_path : update_step_two_task_path(@task)
  end

  def submit_text
    @task.new_record? ? 'Create Task' : 'Update Task'
  end

  def submit_text_step_two
    @task.new_record? ? 'Add Services' : 'Update Services'
  end

  def submit_text_step_three
    @task.new_record? ? 'Add Description' : 'Update Description'
  end

  def back_to_step_one
    @task.new_record? ? new_step_one_tasks_path : edit_step_one_task_path
  end

  def back_to_step_two
    @task.new_record? ? new_step_two_tasks_path : edit_step_two_task_path
  end
end
