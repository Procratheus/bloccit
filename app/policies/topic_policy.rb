class TopicPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    record.public? || user.present?
  end

  def new?
    user.present? && user.admin?
  end

  def update?
    new?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
