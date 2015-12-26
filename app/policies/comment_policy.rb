class CommentPolicy < ApplicationPolicy

  def new?
    user.present?
  end

  def create?
    new?
  end

  def destroy
    user.present? && ( record.user == user || user.moderator? || user.admin? )
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
