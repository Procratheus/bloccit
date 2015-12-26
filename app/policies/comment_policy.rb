class CommentPolicy < ApplicationPolicy

  def new?
    user.present?
  end

  def create?
    new?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
