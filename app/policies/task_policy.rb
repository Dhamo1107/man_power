class TaskPolicy < ApplicationPolicy

  def update_status?
    assigned_user = record.assigned_to_user_id
    created_user = record.created_by_user_id

    case record.status
    when 'created', 'viewed'
      user.id == assigned_user
    when 'accepted', 'in_progress'
      user.id == created_user
    else
      false
    end
  end

  def permitted_statuses
    case record.status
    when 'created'
      ['viewed']
    when 'viewed'
      ['accepted', 'cancelled']
    when 'accepted'
      ['in_progress']
    when 'in_progress'
      ['completed']
    else
      []
    end
  end
end